Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306F4FF19C
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiDMITK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Apr 2022 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiDMITJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Apr 2022 04:19:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8904E3B2
        for <linux-ext4@vger.kernel.org>; Wed, 13 Apr 2022 01:16:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABB38210F4;
        Wed, 13 Apr 2022 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649837807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RriRWqE/2+pwzs0/qx0hSB4s2SRJ3d29qzhP9Y2SArc=;
        b=H9gJoYhYZqqXH1EEJQ6J/IO+FfQY69uzSlEmnyA2mN1RJogZR+4rD+V23nGX9p91NHrxVK
        PV9VqO3e9SeVv6Cp4lsiK2XAujV+U/HJJPs1TYqUgfGEqHXJ88cLMlzo3lY3aJYruQkDOo
        bY7iKzb3mEMhaOzSghLQgCOQQsRqVLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649837807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RriRWqE/2+pwzs0/qx0hSB4s2SRJ3d29qzhP9Y2SArc=;
        b=dx/rqVafXrkPsGDPKFCBfET7iXK0GGaGE2h5qlYwkGA1wnBj6SrW3spfnUDUMADX37Vms0
        m1xRNv/iWsyk4oBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97141A3B9A;
        Wed, 13 Apr 2022 08:16:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D529AA0615; Wed, 13 Apr 2022 10:16:44 +0200 (CEST)
Date:   Wed, 13 Apr 2022 10:16:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com, yebin10@huawei.com, liuzhiqiang26@huawei.com,
        liangyun2@huawei.com
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Message-ID: <20220413081644.t2k24yx5gtarpjlg@quack3.lan>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
 <87pmlmcmu6.fsf@collabora.com>
 <YlYo/FqujCnUHH6X@mit.edu>
 <fe9fcfcd-7c6c-19eb-525c-f8a79804481c@huawei.com>
 <20220413035107.GA16747@magnolia>
 <e13dd15a-e394-6408-217c-e5f1aaa09c47@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13dd15a-e394-6408-217c-e5f1aaa09c47@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 13-04-22 14:33:53, Zhang Yi wrote:
> On 2022/4/13 11:51, Darrick J. Wong wrote:
> > On Wed, Apr 13, 2022 at 10:23:31AM +0800, Zhang Yi wrote:
> >> On 2022/4/13 9:35, Theodore Ts'o wrote:
> >>> On Tue, Apr 12, 2022 at 12:01:37PM -0400, Gabriel Krisman Bertazi wrote:
> >>>> Zhang Yi <yi.zhang@huawei.com> writes:
> >>>>
> >>>>> Now that we have kernel message at mount time, system administrator
> >>>
> >>> "Now that we have...." is a bit misleading, since (at least to an
> >>> English speaker) that this is something that was recently added, and
> >>> that's not the case.
> >>>
> >>>>> could acquire the mount time, device and options easily. But we don't
> >>>>> have corresponding unmounting message at umount time, so we cannot know
> >>>>> if someone umount a filesystem easily. Some of the modern filesystems
> >>>>> (e.g. xfs) have the umounting kernel message, so add one for ext4
> >>>>> filesystem for convenience.
> >>>>>
> >>>>>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
> >>>>>  EXT4-fs (sdb): unmounting filesystem.
> >>>>
> >>>> I don't think sysadmins should be relying on the kernel log for this,
> >>>> since the information can easily be overwritten by new messages there.
> >>>> Is there a reason why you can't just monitor /proc/self/mountinfo?
> >>>
> >>> You're right that it can be dangerous for sysadmins to be relying on
> >>> the kernel log for mount and umount notifications --- but it depends
> >>> on what they think it means, and the potential pitfalls are there for
> >>> both the mount and unmount messages.  The problem of course, is that
> >>> bind mounts, and mount name spaces, so if the question is whether a
> >>> file system is available at a particular mount point, then using the
> >>> kernel log is definitely not going to be reliable.
> >>>
> >>> But if the goal is to determine whether a particular device is safe to
> >>> run fsck or otherwise access directly, or for the purposes of
> >>> debugging the kernel and looking at the logs to understand when the
> >>> device is being accessed by the kernel and when the file system is
> >>> done with the device, I can see how it might be useful.
> >>>
> >>
> >> Yes, I understand that the kernel log is not reliable, and
> >> /proc/self/mountinfo neither. Our goal is simple, As Ted said, just add a
> >> method to help sysadmins to know whether a particular ext4 device is really
> >> doing unmount procedure, it could be helpful for us to debug kernel and
> >> locate kernel bug.
> > 
> > But if the mount/unmount messages are ratelimited, how will you know for
> > sure if the ratelimiting mechanism elides the message?
> > 
> 
> This is to be expected that the messages are ratelimited, it's just a "try best"
> way to let us acquire more information, it's best if it write something down and
> not surprising if not. If the messages are ratelimited will get the "...suppressed"
> message and could know what happened, we will combine other logs (e.g. systemd log)
> to make things clear as far as possible.

Just to add my 2c, several times when I was debugging some issue and
staring into the kernel logs, I was trying to figure out whether some ext4
filesystem was still mounted or not and a message about unmounting a fs in
the kernel log would have been useful to me (e.g. when I was trying to
figure out whether a shared device with ext4 filesystem got really mounted
from two nodes at once or whether it was first unmounted on one of the
nodes). Sure, you can live without that and sure it isn't 100% reliable in
all the corner cases but it is convenient at times...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
