Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1A15A700
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBLKu2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Feb 2020 05:50:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKu2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Feb 2020 05:50:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so834650plb.0;
        Wed, 12 Feb 2020 02:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwYUt36/m5Zra9oiWnv5NglJ51Q8JRyxfXbpzb8jNMo=;
        b=YFhtNSX2HQfROr6X2rfRntcwEYqvfehNLEdmf2lgJ+WO9/+QsLA7DIEoLdYr/cO8Iq
         xh71UXRcbEzYM6wexqqD9g+Fl7bw5IZiCWqdxHkicngBTraUPWnRvT0IQg+U4NAIj+0v
         BGAsSXGLiO+EzVZMmhJSVsANUjLQ7ANixOJKoLMvCYczq52oDxqFDxcDJeX1+HU2vvAc
         UWoEJmIYtt21dCg6v1Z7EOL5ztQC9TaFnlkV5XBgXvaqIL7x65LHmPuuu0YUrjU6yjK+
         XmZCSupkTQzKuzH0p7bTXT/eelKq+x756T6VunGkVxU82kaEXXixU3WLWQnQ4H3kcUGz
         LGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwYUt36/m5Zra9oiWnv5NglJ51Q8JRyxfXbpzb8jNMo=;
        b=KSLwvcAo47cs95LWXE7MM48NGYFRJLHkJlvXuicomXhtoUnr5KXIqZQ3QcDi0ivWdi
         2jht31ab5s27ggPEoeLMVmWKyICCgG+6FNrScJBSbVSMg7xo/6xhfbHm7io9GDtjTvYJ
         cSnYWPC/DV09DaBTETSyBZm43hEPSS4QpVDwVO+py0lUxDk2yhH7IVCGezcbX0AUI2AQ
         3JHPNMJL1s+x/ptxAKvcmfED2r45nBgpBouZarhAy8Bq/Xjn0Uq3NNsa238jpKFjO+4H
         yRybhx3c2LNdLbQ8dN2TrBy97amS2pdd1XBMADRfCDghOokCDfu9Mo0QgVX8sRya4qhX
         qcYQ==
X-Gm-Message-State: APjAAAVK9Nyou5AJCXse+hHEe2bxqmosS8orKj9E/voQgkkkvNfu5E3P
        qHp5BzGXM6SxgaPDZNjo0oepDfpz
X-Google-Smtp-Source: APXvYqx7vb0poKTK4gqwe4IOMPVElxX76jI2v8Y03uSAcMQ6UdVEsm13u5A1ppfdOfTqwu2JRiBD4A==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr22203579plr.126.1581504627326;
        Wed, 12 Feb 2020 02:50:27 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r62sm389569pfc.89.2020.02.12.02.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:50:26 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:50:19 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: ext4 dio RWF_NOWAIT change
Message-ID: <20200212105019.5zah56u2l47oh3gf@xzhoux.usersys.redhat.com>
References: <20200205091344.u5c3nnblezzh5xgb@xzhoux.usersys.redhat.com>
 <20200207153824.GA122530@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207153824.GA122530@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 07, 2020 at 10:38:24AM -0500, Theodore Y. Ts'o wrote:
> On Wed, Feb 05, 2020 at 05:13:44PM +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > Kernel commit 378f32bab3714f04c4e0c3aee4129f6703805550
> > Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Date:   Tue Nov 5 23:02:39 2019 +1100
> > 
> >     ext4: introduce direct I/O write using iomap infrastructure
> > 
> > 
> > Changed the logic of dio+RWF_NOWAIT
> > 
> > from:
> > 
> > -       if (!inode_trylock(inode)) {
> > -               if (iocb->ki_flags & IOCB_NOWAIT)
> > -                       return -EAGAIN;
> > -               inode_lock(inode);
> > -       }
> > 
> > 
> > to:
> > 
> > +       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +               if (!inode_trylock(inode))
> > +                       return -EAGAIN;
> > +       } else {
> > +               inode_lock(inode);
> > +       }
> > 
> > 
> > fstests generic/471 expecet EAGAIN on this situation, so it started to
> > fail since than.
> 
> I don't understand why this specific change would cause the situation.
> In the generic/471 test, here iocb->ki_flags will have IOCB_NOWAIT
> set, and in that case I don't see how there would be a change in
> behavior with respect to EAGAIN being returned.
> 
> In any case, I've been suppressing generic/471 because of concerns
> that the test is bogus so I hadn't noticed.  From
> kvm-xfstests/test-appliance/files/root/fs/global_exclude:
> 
> # The test generic/471 tests the RWF_NOWAIT flag; however
> # how it is supposed to work with file systems is disputed,
> # and not all device drivers support it.  As a result
> # it doesn't work if an LVM device driver is in use (as is the
> # case with gce-xfstests).  So let's suppress it for now.  For
> # more details see:
> # https://lore.kernel.org/linux-block/20190723220502.GX7777@dread.disaster.area/
> generic/471
> 
> 							- Ted

Thanks for all the details! Ted.

Murphy
