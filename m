Return-Path: <linux-ext4+bounces-4190-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDA97A66B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F1F1C21241
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D9481B6;
	Mon, 16 Sep 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh/giCN6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBE1B7E9
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506234; cv=none; b=jGyDgKkiyC7hdmiX0K5fZ+FhTfqS9ThyRcr07MFSQa7xh8iWd/Ve4aEZj+ZBWh5XBwf7cEd6uRPwy/BgXiqKp+IUympdXbDgNr0HcEDEcs7zzNNjZ3H0vaIeZllkYe/B0ECJoZNF6Pw/ZmhwCwOWGmp4hWt07Bkd1fgOspq84iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506234; c=relaxed/simple;
	bh=WQKyW3dBfy5jRjDv3RK/3BRWs48E9HMsoj1BVP3PR8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EWwJV9jFkQLZaN9sxzRx5CiTXNJTGtkAC0H8UTAtHfWlUQpAF/+xGl/EhhjRo1Ao8FkxZ200o57kDsFvSQR3cq7VDp2NqQUqnSZb4xneRCmnEH3kIWfpNW0WWNYPzSBMlnGrEWEqCrEfB6lXc1yvqpV3zO/l0ZN8VnwNQvu8Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh/giCN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9028CC4CEC5
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726506233;
	bh=WQKyW3dBfy5jRjDv3RK/3BRWs48E9HMsoj1BVP3PR8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sh/giCN6S8vV152liMP140TqPGXtjlTD7Any48T0vBj/lJgF1doGLCwynH42pVOUw
	 4U5EnryPthLhvL1h+XnckbaRlz6DtY2c9OgMGPAtSAawHcLcF+3B/dYuU+G2DzapQn
	 5uIhOXkGfe+kUTknwlYAkayib7eNl7ZpzS19UU2TabGwH/wjcLlp8WJb8AFGe5kpuj
	 Wz7etBlUEK+bS6TCrooMZVvZUqP9hDQXPdXafQR2Z9lhmjay/RRnSCnm6qUjbdFrAO
	 qstx+GU7MVzXe9c0UbgXFHVaeBHpQw9Bu+LauzbUYl9qtqcxQUQPVlFEKtmBIfVY9+
	 hUhun+EMTeXMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F900C53BB8; Mon, 16 Sep 2024 17:03:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 17:03:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219283-13602-1u7VZYnTLI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
OK, so you've isolated it to something between 6.9 and 6.10.   Any chance y=
ou
could do further bisection work?   Thanks!!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

