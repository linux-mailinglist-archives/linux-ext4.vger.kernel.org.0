Return-Path: <linux-ext4+bounces-6921-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD70A68D65
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 14:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C43ACF62
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E004251799;
	Wed, 19 Mar 2025 13:06:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094132512EF
	for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389560; cv=none; b=OF48PtcpF4uRiX1GigD4R5BLN4ZZc+dFAPtZiRhPdSo9BkkA+lv+4fi7dbGzEDaTOAOcXdbl9iS1jDNdzV/h8GCYPJDenWEZicA6MWxLsKgAGZCWo0FSpWwQrabDnSD5U8wdOQaORxHGwRkiNEGOHC8AtMlki8iQ9e0veThlolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389560; c=relaxed/simple;
	bh=et1oXos2YNWRVBx3UDWjtmFcm8BvWiVad8OSF+JTXrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSzHQ1SYJVmgCR8LYQ7Z7EPDg8XqYqRjoNNPYW4PRovalEYG7CfFQxpZ8jxsi8QAuJanluya28YpcejiNfRKOSJ2xFCx/MReCG+MQV1fIWjYo8zv9re3gnMAFhexkzrEI5hGH0mHfTuOr8/R+T+ensjl/3VWe8Ap53Y82jCH0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JD5hQu012558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:05:44 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A44FD2E010B; Wed, 19 Mar 2025 09:05:43 -0400 (EDT)
Date: Wed, 19 Mar 2025 09:05:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakub Acs <acsjakub@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] ext4: fix OOB read when checking dotdot dir
Message-ID: <20250319130543.GA1061595@mit.edu>
References: <20250319110134.10071-1-acsjakub@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319110134.10071-1-acsjakub@amazon.com>

On Wed, Mar 19, 2025 at 11:01:34AM +0000, Jakub Acs wrote:
> If the rec_len of '.' is precisely one block (4KB), it slips through the
> sanity checks (it is considered the last directory entry in the data
> block) and leaves "struct ext4_dir_entry_2 *de" point exactly past the
> memory slot allocated to the data block. The following call to
> ext4_check_dir_entry() on new value of de then dereferences this pointer
> which results in out-of-bounds mem access.
> 
> Fix this by extending __ext4_check_dir_entry() to check for '.' dir
> entries that reach the end of data block. Make sure to ignore the phony
> dir entries for checksum (by checking name_len for non-zero).
> 
> Note: This is reported by KASAN as use-after-free in case another
> structure was recently freed from the slot past the bound, but it is
> really an OOB read.

Well, a (non-inline) directory where '.' is a single directory entry
that fills the file system block should (probably) never occur in
nature.  So from that perspective, the check that you propose is
probably fine.

HOWEVER.  The check that e2fsck does is slightly different, which is
stronger in some ways, and weaker than others relative to what you
propose.  What e2fsck checks for non-inline directory is that '.' must
be first entry, and '..' must be the second directory entry.

So if somehow, a file system gets created where '.' is the first entry
that fills the first directory block, and '..' is the second entry
which is at the beginning of the second directory block, we would be
in the interesting situation where it's possible that the kernel would
report the file system to be corrupted --- not in the case of
check_empty_dir() used in the rmdir_path, but there are other calls to
check_dir_entry that will result in the file system to be declare
corrupted --- then when the user runs e2fsck on a file system declared
corrupted by the kernel, e2fsck would return a Big Thumbs Up; but then
when the kernel trips over that directory again, it would get declared
corrupted again.

So this ultimately turns on the definition of "valid".  If the
definition is "could this happen naturally, at least using all Linux
implementations that I'm aware of", then no, it's not valid.  However,
if there is some other implementation of ext2/ext3/ext4 (say, BSD,
Hurd, etc.), or a potentially malicious user (or a fuzzer) carefully
crafts a file system, and e2fsck reports that the file system doesn't
have any problems, then yes there _could_ be valid file systems where
'.' is both the first and last directory entry.

Is it likely that there are other legitimate implementations that
would create such a file system?  No, it's highly unlikely.  So one
approach might be to make this change in what is officially considered
valid as defined by e2fsck.  The downside of this would be that there
could be a version skew, where the kernel change gets backported into
an LTS kernel, but the user doesn't upgrade to a newer version of
e2fsprogs, the user might get confused.

In this particular case, I think it's worthwhile to make the change,
since if we don't make the change in __ext4_check_dir_entry(), it's
not enough to make a change in ext4_empty_dir().  We'd have to audit
*all* of check_dir_entry's, and a quick check indicates we'd also need
to add a check to ext4_get_first_dir_block().

> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 02d47a64e8d1..d157a6c0eff6 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -104,6 +104,9 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
>  	else if (unlikely(le32_to_cpu(de->inode) >
>  			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
>  		error_msg = "inode out of bounds";
> +	else if (unlikely(de->name_len > 0 && strcmp(".", de->name) == 0 &&
> +			  next_offset == size))
> +		error_msg = "'.' directory cannot be the last in data block";
>  	else
>  		return 0;

I'd change the check to:

	else if (unlikely(next_offset == size && de->name_len == 1 &&
			  strcmp(".", de->name) == 0))

which is a bit more optimized.

So if you resend this commit with this change, and remove the question
to the ext4 maintainers (for future reference, it's best to put things
that don't need to be in the commit if the patch gets accepted after
the '---' line and before the diffstat, since that way if the
maintainer is ready to accept the patch, they won't have the edit the
commit description), I'd be happy to accept the patch.

Also, the best way to test a commit is not just to run all of the
ext4/* xfstests patches, but to run a smoke test.  If you use
kvm-xfstests[1], you can do this via "kvm-xfstests smoke", which is
syntactic sugar for "SOAK_DURATION=3m check -g smoketest" and will
take 15-20 minutes.  If you want to spend a bit more time, you can run
the quick group ("check -g quick" or "kvm-xfstests -c ext4/4k -g
quick").

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

The reason why I mention using kvm-xfstests is because in the future,
if you try your hand at fixing a syzbot issue that uses a slightly
more exotic feature, such as inline_data, you'd want to do something
like "kvm-xfstests -c ext4/inline <test_specifiers>" so that the file
system is set up correctly for testing those code paths.  And of
course, for more testing fun, please see gce-xfstests[2].

[2] https://thunk.org/gce-xfstests

Many thanks,

					- Ted

P.S.  If anyone is interested in adding support for other cloud
platforms such as Amazon and Azure as an additional back ends to
xfstests-bld -- we have support for MacOS's hvf, Docker and Android as
back ends, and more would be great; please contact me.  Patches
Gratefully Accepted.  :-)

