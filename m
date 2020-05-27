Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104111E3F0A
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 12:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgE0KcZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 06:32:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728930AbgE0KcZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 06:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590575543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZTEy04UBF0iwux43Nv23Qi2SM7lukDF7nQeck/HwrH0=;
        b=TduV7C4N2UEdv0ktq5Y3rBj5LlXmkJqHGPk9/Qy+H60Eq6Zi2TsJew8cju+iedWbBRYU0Q
        nRUt6zYi2Uf8tHIHzsAat8RzzoOoXxvlu/BBqUokY6vW8bCCKVKWK6i25CKG9e2ttHQzDk
        RXCgl25qRiQ6+ma4XYqI1rYOYqQLTEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Ms4KzrvzMEyoOl8nNynPkw-1; Wed, 27 May 2020 06:32:22 -0400
X-MC-Unique: Ms4KzrvzMEyoOl8nNynPkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B758F1801802;
        Wed, 27 May 2020 10:32:20 +0000 (UTC)
Received: from work (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1A25C1B0;
        Wed, 27 May 2020 10:32:19 +0000 (UTC)
Date:   Wed, 27 May 2020 12:32:14 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Message-ID: <20200527103214.knm2vmnwjt64j55l@work>
References: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
 <20200527091938.647363ekmnz7av7y@work>
 <520b260b-13e9-4c62-eaeb-c44215b14089@thelounge.net>
 <20200527095751.7vt74n7grfre6wit@work>
 <59df4f2f-f168-99a1-e929-82742693f8ee@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59df4f2f-f168-99a1-e929-82742693f8ee@thelounge.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 27, 2020 at 12:11:52PM +0200, Reindl Harald wrote:
> 
> Am 27.05.20 um 11:57 schrieb Lukas Czerner:
> > On Wed, May 27, 2020 at 11:32:02AM +0200, Reindl Harald wrote:
> >>
> >>
> >> Am 27.05.20 um 11:19 schrieb Lukas Czerner:
> >>> On Wed, May 27, 2020 at 04:38:50PM +0900, Wang Shilong wrote:
> >>>> From: Wang Shilong <wshilong@ddn.com>
> >>>>
> >>>> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> >>>> remounted, fstrim need walk all block groups again, the problem with
> >>>> this is FSTRIM could be slow on very large LUN SSD based filesystem.
> >>>>
> >>>> To avoid this kind of problem, we introduce a block group flag
> >>>> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> >>>> extra one block group dirty write after trimming block group.
> >>
> >> would that also fix the issue that *way too much* is trimmed all the
> >> time, no matter if it's a thin provisioned vmware disk or a phyiscal
> >> RAID10 with SSD
> > 
> > no, the mechanism remains the same, but the proposal is to make it
> > pesisten across re-mounts.
> > 
> >>
> >> no way of 315 MB deletes within 2 hours or so on a system with just 485M
> >> used
> > 
> > The reason is that we're working on block group granularity. So if you
> > have almost free block group, and you free some blocks from it, the flag
> > gets freed and next time you run fstrim it'll trim all the free space in
> > the group. Then again if you free some blocks from the group, the flags
> > gets cleared again ...
> > 
> > But I don't think this is a problem at all. Certainly not worth tracking
> > free/trimmed extents to solve it.
> 
> it is a problem
> 
> on a daily "fstrim -av" you trim gigabytes of alredy trimmed blocks
> which for example on a vmware thin provisioned vdisk makes it down to
> CBT (changed-block-tracking)
> 
> so instead completly ignore that untouched space thanks to CBT it's
> considered as changed and verified in the follow up backup run which
> takes magnitutdes longer than needed

Looks like you identified the problem then ;)

But seriously, trim/discard was always considered advisory and the
storage is completely free to do whatever it wants to do with the
information. I might even be the case that the discard requests are
ignored and we might not even need optimization like this. But
regardless it does take time to go through the block gropus and as a
result this optimization is useful in the fs itself.

However it seems to me that the situation you're describing calls for
optimization on a storage side (TP vdisk in your case), not file system
side.

And again, for fine grained discard you can use -o discard.

-Lukas

> 
> without that behavior our daily backups would take 3 minutes instead 1
> hour but without fstrim the backup grows with useless temp data over time
> 

