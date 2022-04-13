Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E804FEC56
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiDMBip (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 21:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDMBio (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 21:38:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC444757
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 18:36:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23D1Zumo012270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:35:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3627F15C003E; Tue, 12 Apr 2022 21:35:56 -0400 (EDT)
Date:   Tue, 12 Apr 2022 21:35:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        yebin10@huawei.com, liuzhiqiang26@huawei.com, liangyun2@huawei.com
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Message-ID: <YlYo/FqujCnUHH6X@mit.edu>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
 <87pmlmcmu6.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmlmcmu6.fsf@collabora.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 12, 2022 at 12:01:37PM -0400, Gabriel Krisman Bertazi wrote:
> Zhang Yi <yi.zhang@huawei.com> writes:
> 
> > Now that we have kernel message at mount time, system administrator

"Now that we have...." is a bit misleading, since (at least to an
English speaker) that this is something that was recently added, and
that's not the case.

> > could acquire the mount time, device and options easily. But we don't
> > have corresponding unmounting message at umount time, so we cannot know
> > if someone umount a filesystem easily. Some of the modern filesystems
> > (e.g. xfs) have the umounting kernel message, so add one for ext4
> > filesystem for convenience.
> >
> >  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
> >  EXT4-fs (sdb): unmounting filesystem.
> 
> I don't think sysadmins should be relying on the kernel log for this,
> since the information can easily be overwritten by new messages there.
> Is there a reason why you can't just monitor /proc/self/mountinfo?

You're right that it can be dangerous for sysadmins to be relying on
the kernel log for mount and umount notifications --- but it depends
on what they think it means, and the potential pitfalls are there for
both the mount and unmount messages.  The problem of course, is that
bind mounts, and mount name spaces, so if the question is whether a
file system is available at a particular mount point, then using the
kernel log is definitely not going to be reliable.

But if the goal is to determine whether a particular device is safe to
run fsck or otherwise access directly, or for the purposes of
debugging the kernel and looking at the logs to understand when the
device is being accessed by the kernel and when the file system is
done with the device, I can see how it might be useful.

Cheers,

						- Ted
