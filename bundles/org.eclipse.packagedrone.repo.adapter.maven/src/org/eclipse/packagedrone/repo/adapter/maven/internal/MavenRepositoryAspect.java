/*******************************************************************************
 * Copyright (c) 2015 IBH SYSTEMS GmbH.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBH SYSTEMS GmbH - initial API and implementation
 *******************************************************************************/
package org.eclipse.packagedrone.repo.adapter.maven.internal;

import org.eclipse.packagedrone.repo.aspect.ChannelAspect;
import org.eclipse.packagedrone.repo.aspect.aggregate.ChannelAggregator;
import org.eclipse.packagedrone.repo.manage.system.SitePrefixService;

public class MavenRepositoryAspect implements ChannelAspect
{
    private final SitePrefixService sitePrefixService;

    public MavenRepositoryAspect ( final SitePrefixService sitePrefixService )
    {
        this.sitePrefixService = sitePrefixService;
    }

    @Override
    public String getId ()
    {
        return MavenRepositoryAspectFactory.ID;
    }

    @Override
    public ChannelAggregator getChannelAggregator ()
    {
        return new MavenRepositoryChannelAggregator ( this.sitePrefixService );
    }
}
