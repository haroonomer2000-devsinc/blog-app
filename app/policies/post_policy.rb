# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    # scope.all
    # end
  end

  def create?
    destroy?
  end

  def edit?
    destroy?
  end

  def update?
    destroy?
  end

  def destroy?
    @user.id == @record.user_id
  end
end
