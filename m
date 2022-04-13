Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60094FEDC3
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 05:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiDMDxc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 23:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDMDxb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 23:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05786101D0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 20:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E42CB82071
        for <linux-ext4@vger.kernel.org>; Wed, 13 Apr 2022 03:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98ACC385A4;
        Wed, 13 Apr 2022 03:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649821867;
        bh=Xy+MZTM7+SlMWzzvy6i+LW08kJYSnB+I8y42imG4iEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUXJRWDB4LEiS+BEKYXjbMkmWt7Xc38RDkl0QZocNa0blvOKGh0IcNwbbLLJ8Fthc
         9sfJlgYlOQMCB1ThkuPWxZ9raPYRkikANAZ9Qjjvk0ZMDWxKWBwPIYuSJbW8oS90rF
         oRe+MTmT2DUa+zZJvx6C21CR5PcBKCnKQvgFwXk4pbwWZ5lF1ZpMKHw1OjtLShY0MS
         p10WRWqv6R00z0qP7jf9RJAPL58X1nZ8ZuVvVWHFAjOMzT8YYiAM4H4XifMaxpEMmE
         f8++pd+mjLxsivag8XYImcBKFKexAu7YqXhRGvh/igt4CcNo3/hUyQwCmsEpKy9JYX
         8cdKsfiD1cz5Q==
Date:   Tue, 12 Apr 2022 20:51:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com, yebin10@huawei.com, liuzhiqiang26@huawei.com,
        liangyun2@huawei.com
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Message-ID: <20220413035107.GA16747@magnolia>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
 <87pmlmcmu6.fsf@collabora.com>
 <YlYo/FqujCnUHH6X@mit.edu>
 <fe9fcfcd-7c6c-19eb-525c-f8a79804481c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9fcfcd-7c6c-19eb-525c-f8a79804481c@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 13, 2022 at 10:23:31AM +0800, Zhang Yi wrote:
> On 2022/4/13 9:35, Theodore Ts'o wrote:
> > On Tue, Apr 12, 2022 at 12:01:37PM -0400, Gabriel Krisman Bertazi wrote:
> >> Zhang Yi <yi.zhang@huawei.com> writes:
> >>
> >>> Now that we have kernel message at mount time, system administrator
> > 
> > "Now that we have...." is a bit misleading, since (at least to an
> > English speaker) that this is something that was recently added, and
> > that's not the case.
> > 
> >>> could acquire the mount time, device and options easily. But we don't
> >>> have corresponding unmounting message at umount time, so we cannot know
> >>> if someone umount a filesystem easily. Some of the modern filesystems
> >>> (e.g. xfs) have the umounting kernel message, so add one for ext4
> >>> filesystem for convenience.
> >>>
> >>>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
> >>>  EXT4-fs (sdb): unmounting filesystem.
> >>
> >> I don't think sysadmins should be relying on the kernel log for this,
> >> since the information can easily be overwritten by new messages there.
> >> Is there a reason why you can't just monitor /proc/self/mountinfo?
> > 
> > You're right that it can be dangerous for sysadmins to be relying on
> > the kernel log for mount and umount notifications --- but it depends
> > on what they think it means, and the potential pitfalls are there for
> > both the mount and unmount messages.  The problem of course, is that
> > bind mounts, and mount name spaces, so if the question is whether a
> > file system is available at a particular mount point, then using the
> > kernel log is definitely not going to be reliable.
> > 
> > But if the goal is to determine whether a particular device is safe to
> > run fsck or otherwise access directly, or for the purposes of
> > debugging the kernel and looking at the logs to understand when the
> > device is being accessed by the kernel and when the file system is
> > done with the device, I can see how it might be useful.
> > 
> 
> Yes, I understand that the kernel log is not reliable, and
> /proc/self/mountinfo neither. Our goal is simple, As Ted said, just add a
> method to help sysadmins to know whether a particular ext4 device is really
> doing unmount procedure, it could be helpful for us to debug kernel and
> locate kernel bug.

But if the mount/unmount messages are ratelimited, how will you know for
sure if the ratelimiting mechanism elides the message?

--D

> Thanks,
> Yi.
> 
> 
> 
