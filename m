Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10FE765A2C
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjG0R2v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjG0R2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 13:28:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7B2D67;
        Thu, 27 Jul 2023 10:28:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6BAD1F86A;
        Thu, 27 Jul 2023 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690478927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hizQDsnFuuP2pdeFRj2IG09/O7pjInD48Rh1G/ocOVg=;
        b=vr7Wzyrk9GjUCRVrsSXymT6tOWQfdocwDyoXtQtO2mlYFcwr/w34iyrFjiyKXtwrWPE2q9
        FFDmDG2ncyW7rHDhXuejTMqj20oLu0JmiOhFDbF1sR3oJLHFaLQjShsgJpqcr/oYqJQvoz
        5sdULBGyXXn8jYmaB0zMrjS+iE6HOr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690478927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hizQDsnFuuP2pdeFRj2IG09/O7pjInD48Rh1G/ocOVg=;
        b=srUPfrj9RW9/PHS/ZT5J57GH2zz38cfJ/lQyC2FYJ3VzGtxAFGYOlMOJKEA2KnizycJ05K
        lNSOrXkk6CHhVABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B171F13902;
        Thu, 27 Jul 2023 17:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xtAlH0+pwmSvaAAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 27 Jul 2023 17:28:47 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v4 0/7] Support negative dentries on case-insensitive ext4 and f2fs
Date:   Thu, 27 Jul 2023 13:28:36 -0400
Message-ID: <20230727172843.20542-1-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This is the v4 of the negative dentry support on case-insensitive
directories.  It doesn't have any functional changes from v1. It applies
Eric's comments to bring the flags check closet together, improve the
documentation and improve comments in the code.  I also relooked at the
locks to ensure the inode read lock is indeed enough in the lookup_slow
path.

As usual, retested with xfstests.

--
cover letter from v1.

This patchset enables negative dentries for case-insensitive directories
in ext4/f2fs.  It solves the corner cases for this feature, including
those already tested by fstests (generic/556).  It also solves an
existing bug with the existing implementation where old negative
dentries are left behind after a directory conversion to
case-insensitive.

Testing-wise, I ran sanity checks to show it properly uses the created
negative dentries, observed the expected performance increase of the
dentry cache hit, and showed it survives the quick group in fstests on
both f2fs and ext4 without regressions.

* Background

Negative dentries have always been disabled in case-insensitive
directories because, in their current form, they can't provide enough
assurances that all the case variations of a filename won't exist in a
directory, and the name-preserving case-insenstive semantics
during file creation prevents some negative dentries from being
instantiated unmodified.

Nevertheless, for the general case, the existing implementation would
already work with negative dentries, even though they are fully
disabled. That is: if the original lookup that created the dentry was
done in a case-insensitive way, the negative dentry can usually be
validated, since it assures that no other dcache entry exists, *and*
that no variation of the file exists on disk (since the lookup
failed). A following lookup would then be executed with the
case-insensitive-aware d_hash and d_lookup, which would find the right
negative dentry and use it.

The first corner case arises when a case-insensitive directory has
negative dentries that were created before the directory was flipped to
case-insensitive.  A directory must be empty to be converted, but it
doesn't mean the directory doesn't have negative dentry children.  If
that happens, the dangling dentries left behind can't assure that no
case-variation of the name exists. They only mean the exact name
doesn't exist.  A further lookup would incorrectly validate them.

The code below demonstrates the problem.  In this example $1 and $2 are
two strings, where:

      (i) $1 != $2
     (ii) casefold($1) == casefold($2)
    (iii) hash($1) == hash($2) == hash(casefold($1))

Then, the following sequence could potentially return a ENOENT, even
though the case-insensitive lookup should exist:

  mkdir  d      <- Case-sensitive directory
  touch  d/$1
  touch  d/$2
  unlink d/$1   <- leaves negative dentry  behind.
  unlink d/$2   <- leaves *another* negative dentry behind.
  chattr +F d   <- make 'd' case-insensitive.
  touch  d/$1   <- Both negative dentries could match. finds one of them,
		   and instantiate
  access d/$1   <- Find the other negative dentry, get -ENOENT.

In fact, this is a problem even on the current implementation, where
negative dentries for CI are disabled.  There was a bug reported by Al
Viro in 2020, where a directory might end up with dangling negative
dentries created during a case-sensitive lookup, because they existed
before the +F attribute was set.

It is hard to trigger the issue, because condition (iii) is hard to test
on an unmodified kernel.  By hacking the kernel to force the hash
collision, there are a few ways we can trigger this bizarre behavior in
case-insensitive directories through the insertion of negative dentries.

Another problem exists when turning a negative dentry to positive.  If
the negative dentry has a different case than what is currently being
used for lookup, the dentry cannot be reused without changing its name,
in order to guarantee filename-preserving semantics to userspace.  We
need to either change the name or invalidate the dentry. This issue is
currently avoided in mainline, since the negative dentry mechanism is
disabled.

* Proposal

The main idea is to differentiate negative dentries created in a
case-insensitive context from those created during a case-sensitive
lookup via a new dentry flag, D_CASEFOLD_LOOKUP, set by the filesystem
the d_lookup hook.  Since the former can be used (except for the
name-preserving issue), d_revalidate will just check the flag to
quickly accept or reject the dentry.

A different solution would be to guarantee no negative dentry exists
during the case-sensitive to case-insensitive directory conversion (the
other direction is safe).  It has the following problems:

  1) It is not trivial to implement a race-free mechanism to ensure
  negative dentries won't be recreated immediately after invalidation
  while converting the directory.

  2) The knowledge whether the negative dentry is valid (i.e. comes from
  a case-insensitive lookup) is implicit on the fact that we are
  correctly invalidating dentries when converting the directory.

Having a D_CASEFOLD_LOOKUP avoids both issues, and seems to be a cheap
solution to the problem.

But, as explained above, due to the filename preserving semantics, we
cannot just validate based on D_CASEFOLD_LOOKUP.

For that, one solution would be to invalidate the negative dentry when
it is decided to turn it positive, instead of reusing it. I implemented
that in the past (2018) but Al Viro made it clear we don't want to incur
costs on the VFS critical path for filesystems who don't care about
case-insensitiveness.

Instead, this patch invalidates negative dentries in casefold
directories in d_revalidate during creation lookups, iff the lookup name
is not exactly what is cached.  Other kinds of lookups wouldn't need
this limitation.

* caveats

1) Encryption

Negative dentries on case-insensitive encrypted directories are also
disabled.  No semantic change for them is intended in
this patchset; we just bypass the revalidation directly to fscrypt, for
positive dentries.  Encryption support is future work.

2) revalidate the cached dentry using the name under lookup

Validating based on the lookup name is strange for a cache.  the new
semantic is implemented by d_revalidate, to stay out of the critical
path of filesystems who don't care about case-insensitiveness, as much
as possible.  The only change is the addition of a new flavor of
d_revalidate.

* Tests

There are a tests in place for most of the corner cases in generic/556.
They mainly verify the name-preserving semantics.  The invalidation when
converting the directory is harder to test, because it is hard to force
the invalidation of specific cached dentries that occlude a dangling
invalid dentry.  I tested it with forcing the positive dentries to be
removed, but I'm not sure how to write an upstreamable test.

It also survives fstests quick group regression testing on both ext4 and
f2fs.

* Performance

The latency of lookups of non-existing files is obviously improved, as
would be expected.  The following numbers compare the execution time of 10^6
lookups of a non-existing file in a case-insensitive directory
pre-populated with 100k files in ext4.

Without the patch: 10.363s / 0.349s / 9.920s  (real/user/sys)
With the patch:     1.752s / 0.276s / 1.472s  (real/user/sys)

* patchset

Patch 1 introduces a new flavor of d_revalidate to provide the
filesystem with the name under lookup; Patch 2 introduces the new flag
to signal the dentry creation context; Patch 3 introduces a libfs helper
to revalidate negative dentries on case-insensitive directories; Patch 4
deals with encryption; Patch 5 cleans up the now redundant dentry
operations for case-insensitive with and without encryption; Finally,
Patch 6 and 7 enable support on case-insensitive directories
for ext4 and f2fs, respectively.

Gabriel Krisman Bertazi (7):
  fs: Expose name under lookup to d_revalidate hook
  fs: Add DCACHE_CASEFOLDED_NAME flag
  libfs: Validate negative dentries in case-insensitive directories
  libfs: Chain encryption checks after case-insensitive revalidation
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  ext4: Enable negative dentries on case-insensitive lookup
  f2fs: Enable negative dentries on case-insensitive lookup

 Documentation/filesystems/locking.rst |   3 +
 Documentation/filesystems/vfs.rst     |  12 ++++
 fs/dcache.c                           |  10 ++-
 fs/ext4/namei.c                       |  35 ++-------
 fs/f2fs/namei.c                       |  25 ++-----
 fs/libfs.c                            | 100 +++++++++++++++++---------
 fs/namei.c                            |  23 +++---
 include/linux/dcache.h                |   9 +++
 8 files changed, 123 insertions(+), 94 deletions(-)

-- 
2.41.0

