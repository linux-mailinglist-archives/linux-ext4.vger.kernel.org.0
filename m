Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5A7C704B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378679AbjJLOaI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjJLOaH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 10:30:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B584C9
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 07:30:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-200.bstnma.fios.verizon.net [173.48.111.200])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39CETIWq012545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1697120962; bh=Fmcr5RwuJwayVhUbngXLq3LrYuBYwHACNuwCZH5c+28=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=W081j5tW+M3CusLvAKm2TNgPiad4Xmuv60pn0cMLFB5AjiGc2JttGCMCA8KlhNMHs
         5C3mCxqhrtR3ekKhhrFTa5qaG9CfpP5HcM0G4rq6Gl4pq5y3M6bUR5tEf+pJaboBZt
         qWn7L6TFYnvU7ekPCViU9Zt/keviwUbXxICidUBi3Rb/Qn/aprQmoDzfYMaWVRh7UQ
         PJDpC0wVBpFM+lxuvMUnfUoexvBEBGwXf4UWADRqQVePUiVW8bQ78sfaFC1Okx50/5
         70AuQDIZz+2Cx7LWvQwUuEuV4LXzBHztnowIu6BW5vFGriao3e79YYlcOaNfKO1dKh
         G/9xFBApDA+rQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6BF5215C0255; Thu, 12 Oct 2023 10:29:18 -0400 (EDT)
Date:   Thu, 12 Oct 2023 10:29:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>,
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
Message-ID: <20231012142918.GB255452@mit.edu>
References: <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu>
 <20231011172606.mztqyvclq6hq2qa2@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011172606.mztqyvclq6hq2qa2@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 07:26:06PM +0200, Jan Kara wrote:
> I don't think this is accurate. posix_acl_create() needs unmasked 'mode'
> because instead of using current_umask() for masking it wants to use
> whatever is stored in the ACLs as an umask.
> 
> So I still think we need to keep umask handling in both posix_acl_create()
> and vfs_prepare_mode(). But filesystem's only obligation would be to call
> posix_acl_create() if the inode is IS_POSIXACL. No more caring about when
> to apply umask and when not based on config or mount options.

Ah, right, thanks for the clarification.  I *think* the following
patch in the ext4 dev branch (not yet in Linus's tree, but it should
be in linux-next) should be harmless, though, right?  And once we get
the changes in vfs_prepare_mode() we can revert in ext4 --- or do
folks I think I should just drop it from the ext4 dev branch now?

Thanks,

						- Ted

commit 484fd6c1de13b336806a967908a927cc0356e312
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Tue Sep 19 10:18:23 2023 +0200

    ext4: apply umask if ACL support is disabled
    
    The function ext4_init_acl() calls posix_acl_create() which is
    responsible for applying the umask.  But without
    CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
    and nobody applies the umask.
    
    This fixes a bug which causes the umask to be ignored with O_TMPFILE
    on ext4:
    
     https://github.com/MusicPlayerDaemon/MPD/issues/558
     https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
     https://bugzilla.kernel.org/show_bug.cgi?id=203625
    
    Reviewed-by: "J. Bruce Fields" <bfields@redhat.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
    Link: https://lore.kernel.org/r/20230919081824.1096619-1-max.kellermann@ionos.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 0c5a79c3b5d4..ef4c19e5f570 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
