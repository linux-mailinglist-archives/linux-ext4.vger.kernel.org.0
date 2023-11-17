Return-Path: <linux-ext4+bounces-29-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6667EFC45
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 00:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04161C20A9D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03664655F;
	Fri, 17 Nov 2023 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbRDXdag"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED518C24
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB8F0C433CB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700265137;
	bh=TSnOeE88Es41CO+rpEfY5AwvCg04q4V2tHnqTxexuYA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MbRDXdagO195fSU7f+vjd+FLsfiYSzNO0QOyPAkv9k8b78rWu9aDOsdjNZ2mtVIIA
	 LMn5ssmWQEDCOLQiKmER03nfbiz13A1omEPKs6HkQHrZNL2rlacx6Zd7P1tJV6euKV
	 ZMtl6J8XwzRWPiFYmAWxbBCUe+MqVJ9kX1Tt7rfvEjZDvGR/kriEcheOU6aTeqMPW6
	 prNPtKRqG9kpiviCVPNE7oxlRHw5kO6VSyT92mj1un3mk1b+MCHWbJWcp+H9t+HuZH
	 nu6GadnEQB1dv88XbRfz4jffmqQriNYAVeieocpTnBrctPQ/zl8y7JuNx8mzlDPDmM
	 cyqMbJGNcY0qA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C84EBC53BCD; Fri, 17 Nov 2023 23:52:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 23:52:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-8f0RNAFQvY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #37 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Finally got it.

kernel 6.5 was easy. kernel-6.4 debuginfo could not be found with 'dnf' and=
 I
searched long for it. Finally locating it on koji.

Then the third probe was wrong, and after some learning I discovered
    $ sudo perf probe --line "ext4_mb_scan_aligned"
     21         while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
     22                 if (!mb_test_bit(i, bitmap)) {
     23                         max =3D mb_find_extent(e4b, i, sbi->s_strip=
e,
&ex);
     24                         if (max >=3D sbi->s_stripe) {
     25                                 ac->ac_found++;
     26                                 ex.fe_logical =3D 0xDEADF00D; /* de=
bug
value */
                                        ac->ac_b_ex =3D ex;
     28                                 ext4_mb_use_best_found(ac, e4b);
     29                                 break;
                                }
                        }
     32                 i +=3D sbi->s_stripe;
                }

and decided to pick line 24 (not the original 26). Is this right?

I will now upload the reports.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

