Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89667C6963
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjJLJWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjJLJWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 05:22:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BEC4;
        Thu, 12 Oct 2023 02:22:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E70C433C8;
        Thu, 12 Oct 2023 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102555;
        bh=AVoONaJXnEpXaoCQ4Sw9bA4Z6lJLX8sVavrkKsLMlV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKX/2tP058GU7x8IhDoq1zWDSz67wQdRrBFkfyFzw+5XOX+dtupVQknNEucodLxl7
         YjXMy9X5QcB3P/V6ZFSx+IRYE9lDE2LAHHCXCK67C0CscqwQbOXhn5p9P8MmUKrB5p
         tut9kV50Boh4XBpZbOyDkT0XjJxQTGGucdYTcdkojcB+GQ02ZO8dTFzdccV/pbvLj/
         Jsn8sFY7M/SRivqqGWWDhIwCH6pXbi+cDsmDmWnbvh3IhjnXS/+wDQfkTAdLbbg0cg
         mdfQhgwgKHjWlp/1B5/lB+EP9214EyC7D5zhYKaAlYfJBmDVbjXGJ6muJUABIgRT9Y
         xMcBUrZq81ejg==
Date:   Thu, 12 Oct 2023 11:22:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231012-klebt-wahljahr-a29e40a2ea2a@brauner>
References: <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011162904.3dxkids7zzspcolp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011162904.3dxkids7zzspcolp@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 06:29:04PM +0200, Jan Kara wrote:
> On Wed 11-10-23 17:27:37, Christian Brauner wrote:
> > On Wed, Oct 11, 2023 at 03:59:22PM +0200, Jan Kara wrote:
> > > On Wed 11-10-23 14:27:49, Max Kellermann wrote:
> > > > On Wed, Oct 11, 2023 at 2:18 PM Max Kellermann <max.kellermann@ionos.com> wrote:
> > > > > But without the other filesystems. I'll resend it with just the
> > > > > posix_acl.h hunk.
> > > > 
> > > > Thinking again, I don't think this is the proper solution. This may
> > > > server as a workaround so those broken filesystems don't suffer from
> > > > this bug, but it's not proper.
> > > > 
> > > > posix_acl_create() is only supposed to appy the umask if the inode
> > > > supports ACLs; if not, the VFS is supposed to do it. But if the
> > > > filesystem pretends to have ACL support but the kernel does not, it's
> > > > really a filesystem bug. Hacking the umask code into
> > > > posix_acl_create() for that inconsistent case doesn't sound right.
> > > > 
> > > > A better workaround would be this patch:
> > > > https://patchwork.kernel.org/project/linux-nfs/patch/151603744662.29035.4910161264124875658.stgit@rabbit.intern.cm-ag/
> > > > I submitted it more than 5 years ago, it got one positive review, but
> > > > was never merged.
> > > > 
> > > > This patch enables the VFS's umask code even if the filesystem
> > > > prerents to support ACLs. This still doesn't fix the filesystem bug,
> > > > but makes VFS's behavior consistent.
> > > 
> > > OK, that solution works for me as well. I agree it seems a tad bit cleaner.
> > > Christian, which one would you prefer?
> > 
> > So it always bugged me that POSIX ACLs push umask stripping down into
> > the individual filesystems but it's hard to get rid of this. And we
> > tried to improve the situation during the POSIX ACL rework by
> > introducing vfs_prepare_umask().
> > 
> > Aside from that, the problem had been that filesystems like nfs v4
> > intentionally raised SB_POSIXACL to prevent umask stripping in the VFS.
> > IOW, for them SB_POSIXACL was equivalent to "don't apply any umask".
> 
> Ah, what a hack...
> 
> > And afaict nfs v4 has it's own thing going on how and where umasks are
> > applied. However, since we now have the following commit in vfs.misc:
> > 
> > commit f61b9bb3f8386a5e59b49bf1310f5b34f47bcef9
> > Author:     Jeff Layton <jlayton@kernel.org>
> > AuthorDate: Mon Sep 11 20:25:50 2023 -0400
> > Commit:     Christian Brauner <brauner@kernel.org>
> > CommitDate: Thu Sep 21 15:37:47 2023 +0200
> > 
> >     fs: add a new SB_I_NOUMASK flag
> > 
> >     SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
> >     also sets this flag to prevent the VFS from applying the umask on
> >     newly-created files. NFSv4 doesn't support POSIX ACLs however, which
> >     causes confusion when other subsystems try to test for them.
> > 
> >     Add a new SB_I_NOUMASK flag that allows filesystems to opt-in to umask
> >     stripping without advertising support for POSIX ACLs. Set the new flag
> >     on NFSv4 instead of SB_POSIXACL.
> > 
> >     Also, move mode_strip_umask to namei.h and convert init_mknod and
> >     init_mkdir to use it.
> > 
> >     Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >     Message-Id: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
> >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > I think it's possible to pick up the first patch linked above:
> >    
> > fix umask on NFS with CONFIG_FS_POSIX_ACL=n doesn't lead to any
> > 
> > and see whether we see any regressions from this.
> > 
> > The second patch I can't easily judge that should go through nfs if at
> > all.
> > 
> > So proposal/question: should we take the first patch into vfs.misc?
> 
> Sounds good to me. I have checked whether some other filesystem does not
> try to play similar games as NFS and it appears not although overlayfs does
> seem to play some games with umasks.

I think that overlayfs sets SB_POSIXACL unconditionally to ensure that
the upper filesystem can decide where the umask needs to be stripped. If
the upper filesystem doesn't have SB_POSIXACL then the umask will be
stripped directly in e.g., vfs_create(), and vfs_tmpfile(). If it does
then it will be done in the upper filesystems.

So with the patch I linked above that we have in vfs.misc we should be
able to  change overlayfs to behave similar to NFS:

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 9f43f0d303ad..361189b676b0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1489,8 +1489,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
        sb->s_xattr = ofs->config.userxattr ? ovl_user_xattr_handlers :
                ovl_trusted_xattr_handlers;
        sb->s_fs_info = ofs;
+#ifdef CONFIG_FS_POSIX_ACL
        sb->s_flags |= SB_POSIXACL;
+#endif
        sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+       /*
+        * Ensure that umask handling is done by the filesystems used
+        * for the the upper layer instead of overlayfs as that would
+        * lead to unexpected results.
+        */
+       sb->s_iflags |= SB_I_NOUMASK;

        err = -ENOMEM;
        root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);

Which means that umask handling will be done by the upper filesystems
just as is done right now and overlayfs can stop advertising SB_POSIXACL
support on a kernel that doesn't have support for it compiled in.

How does that sound?
