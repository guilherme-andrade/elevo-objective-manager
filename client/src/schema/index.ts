export default {
  objectives: {
    type: "objectives",
    fields: {
      id: {
        type: "ID",
        description: "The ID of the objective",
      },
      title: {
        type: "String",
        description: "The title of the objective",
      },
      weight: {
        type: "Int",
        description: "The weight of the objective",
      },
      created_at: {
        type: "Date",
        description: "The date the objective was created",
      },
      updated_at: {
        type: "Date",
        description: "The date the objective was updated",
      },
    },
  },
};
