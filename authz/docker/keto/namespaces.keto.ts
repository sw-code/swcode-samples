import {Namespace, SubjectSet, Context} from "@ory/permission-namespace-types"

class User implements Namespace {
}

class Organization implements Namespace {
    related: {
        viewers: User[]
        editors: User[]
        parents: Organization[]
        owners: User[]
    }

    permits = {
        view: (ctx: Context): boolean =>
            this.related.viewers.includes(ctx.subject) ||
            this.related.parents.traverse((p) => p.permits.view(ctx)) ||
            this.permits.edit(ctx),
        edit: (ctx: Context) =>
            this.related.owners.includes(ctx.subject) ||
            this.related.editors.includes(ctx.subject) ||
            this.related.parents.traverse((p) => p.permits.edit(ctx))
    }
}





