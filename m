Return-Path: <linux-ext4+bounces-3887-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B7395F2F5
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6498FB21918
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3BD13DBB6;
	Mon, 26 Aug 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MZG+zzd8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4797187842
	for <linux-ext4@vger.kernel.org>; Mon, 26 Aug 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679169; cv=none; b=J0f+Pdk+DpY8E5/mwGRfv4bXFe+noodQjiJtg7VMoIVAT3QjJbo0MmWxS413jEd2NDtVG/THuKeuhGNUFl/jhtyMVzD8MkZ0q9teSESo1vUBSDYqhpZ+CDWYUC6oZiCbBNL5GDILH9DTGBGk1110XHTfnZd3rTcFWZKain+WGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679169; c=relaxed/simple;
	bh=n0NPm7B6J7gVDk2ymDoWEA5zA8j5C6+nBCISk/lA5Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALXV0VNHcUtDrf6OE/U7zVTryGspey8SOqNzYebPfAvMxjPV46qTCTPZBCCE189Jc4LVIvRW6M09iQl7SYRXVRpG/pyLi966oDP3a956+5GIYsxSKjJODg6+9nyK1oRZKvoRCMa4y1QTUo5kiJQoH+h07W99lJZfQ0n19+MrJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MZG+zzd8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-154.bstnma.fios.verizon.net [173.48.102.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47QDW8j6004718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 09:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724679132; bh=Fri/kc3dR/ARb2zKFwI6CM6fhXpI4ReBwuWSC6P3TgM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MZG+zzd8YoEYiH+pUWgnfqgM7vJoEyYa4aBt0CagAKr72sOkn/bVYrmB7osXKGjt1
	 Qcg14P5902cyLz5kzCRuTLhMTjs3HwWE4iQu1VPFKpZZP3+bJABRXz2wgL8FvPOSuG
	 /77RJZsWCamci5WSPnuE6kMjQNt2VR95u4rm/QHvtbtkn8nqnoRLw6+6sbe0dBjkqU
	 UkusYmsZzm0g/ylujOXY5rxjCC1vbnhfnsc46E2Og9N4b89qhGb5d+3xOmGsSHgIfv
	 8G9cpRxlV1Co1cnIsN5/LilcyFW0yJ2KqwsugOyQuyx9eGI8q7BslJrwyWGoztjtXV
	 lwBZoaJyYA02A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9C5FB15C02C1; Mon, 26 Aug 2024 09:32:08 -0400 (EDT)
Date: Mon, 26 Aug 2024 09:32:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Cc: syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com, jack@suse.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@fasheh.com, ocfs2-devel@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, ~lkcamp/discussion@lists.sr.ht
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
Message-ID: <20240826133208.GB424729@mit.edu>
References: <00000000000070a66706204e7698@google.com>
 <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>

On Mon, Aug 26, 2024 at 01:22:54AM -0300, Vinicius Peixoto wrote:
> Since the disk data is bogus, journal_reset fails with -EINVAL ("JBD2:
> Journal too short (blocks 2-1024)"); this leaves journal->j_head == NULL.
> However, jbd2_journal_load clears the JBD2_ABORT flag right before calling
> journal_reset. This leads to a problem later when ofcs2_mount_volume tries
> to flush the journal as part of the cleanup when aborting the mount
> operation:
> 
>   -> ofcs2_mount_volume (error; goto out_system_inodes)
>     -> ofcs2_journal_shutdown
>       -> jbd2_journal_flush
>         -> jbd2_cleanup_journal_tail (J_ASSERT fails)
> ...
>
> I confirmed that setting the JBD2_ABORT flag in journal_reset before
> returning -EINVAL fixes the problem:
> 
>         static int journal_reset(journal_t *journal)
>                         journal_fail_superblock(journal);
>         +               journal->j_flags |= JBD2_ABORT;
>                         return -EINVAL;
> 
> You can find a proper patch file + the syzbot re-test result in [1].
> However, I'm not entirely sure whether this is the correct decision, and I
> wanted to confirm that this is an appropriate solution before sending a
> proper patch to the mailing list.

The reason why this isn't an issue with ext4 is because the normal
"right" way to do this is if jbd2_journal_load() returns an error, is
to call jbd2_journal_destroy() to release the data structures with the
journal --- and then don't try to use the journal afterwards.

The weird thing is that there are two code paths in ocfs2 that calls
jbd2_journal_load().  One is in ocfs2_replay_journal() which does what
ext4 does.  The other is ocfs2_load_journal() which does *not* do
this, and this is the one which you saw in the syzkaller reproducer.
It looks like one codepath is used to replay the ocfs2 for some other
node, and the is to load (and presumably later, replay) the journal
for the mounting node.

There are also some other things which look very confusing, such as the fact that ocfs2_journal_shutdown calls igrab:

	/* need to inc inode use count - jbd2_journal_destroy will iput. */
	if (!igrab(inode))
		BUG();

... which is *weird*.  Normaly the journal inode refcount is expected
to be bumped before calling jbd2_journal_init_inode() --- which
normally is done by an iget() function, and is needed to make sure the
journal inode isn't released out from under the jbd2 layer.  It looks
like ocfs2 uses the journal inode for other stuff so get the journal
inode without calling something like iget().  Which is OK, I guess,
but it means that there are a whole bunch of places where it has to
call !BUG_ON(igrab(journal->j_inode) before calling
jbd2_journal_destroy().  It would seem like the *right* thing to do is
to bump the refcount in ocfs2_journal_init(), and if for some reason
the igrab fails, it can just return an error early, instead of having
to resort to BUG_ON() later, and if you don't realize that you have to
do this weird igrab() before calling jbd2_journal_destroy(), you'll
end up leaking the journal inode.

Anyway, I think the right thing to do is to restructure how ocfs2
calls the jbd2 journal, but that's going to require a more careful
examination of the code paths.  Your patch is a bit of a blunt force
hack that should be harmless, but it's probably not the best way to
fix the problem, although doing it "right" would be more
complicated....

					- Ted

