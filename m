Return-Path: <linux-ext4+bounces-1488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF186F925
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF93B20FF9
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2ED6FA7;
	Mon,  4 Mar 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrZ/rKds"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64C53A6
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709525857; cv=none; b=etxNzwlIMZdeyyAyD3q1QljHuJEMqlkjVY409iMTeaMP/gALPQgEcKRBIjIl2S3fmKO8XEFSjZyrWnTZiKxTUff2gOEvvdk4oq0F55ntf+iqizz31hVfi1IMjOS4stztwJAeMVjtEoGxEI+6rdnDH6kfWRMJOfkjIZ8P/4qHdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709525857; c=relaxed/simple;
	bh=o1QH0WSTxjTf8UqfQEUlN8+t1b6EtmYfiS2PNSPOz3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9c9SM8uDZJ7Es5tSUXxQEU4LeRoO70OXBD7dmuu569iRFMkyJGmL+FrRMeZmiZBQSs84GQldpzxnINsoRUam40aXihRM8U8OBOeEnw906uTStSRLz6LWvNylMuULwWHm7EPLPwfDOvlQNOBv2YLt8Hws6/fNe2LbjtFTXEP6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrZ/rKds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D1E8C43394
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 04:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709525855;
	bh=o1QH0WSTxjTf8UqfQEUlN8+t1b6EtmYfiS2PNSPOz3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BrZ/rKdsZb3QFRfvna/pk5sVrb/Ay6pNOZG24zhjKNbENRed4VtF0j42BLNi8LQ16
	 TRoPVfNqCF3a1HLhYa+5PMeITgljuYml/xhCA9gmMCt+XiUIY1YshdFrq+K0mfhkuV
	 ppv+IQiVqWu7yXF9xm+tKRoglcR4Gjv0YR+yrg5/Y+rYQqVITntVFIlCqtC1V/s1X9
	 gBR1tMHeJIkADiej6f0qwwIg5+6+AG3fmXfcXUrEOZPQxXQbtJ3Ho2j2/T8EaNZVKr
	 BMsQVkWKtn9F5D19EsT3GvbL5qdNoG5lqsNUmK1NkIWgFMrh+jQN9w4qoOd4Jh96eC
	 IsoWYjfDl8urw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58E98C53BD0; Mon,  4 Mar 2024 04:17:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Mon, 04 Mar 2024 04:17:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205197-13602-P0hTFieP5O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

Antony Amburose (antony.ambrose@in.bosch.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |antony.ambrose@in.bosch.com

--- Comment #5 from Antony Amburose (antony.ambrose@in.bosch.com) ---
Working with a 5.4.233 on aarch64 (Qualcomm/Android) platform we get the sa=
me
error. I am able to reliably reproduce this problem even after applying the
patch #1.Could you please let me know what additional information required ?
As the partition is FBE encrypted , I am not able to look at the hex dump to
check the nature corruption.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

