Return-Path: <linux-ext4+bounces-4055-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064796D059
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5121C22915
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D9192D81;
	Thu,  5 Sep 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBJj3yWF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36161925BE
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521153; cv=none; b=Y4jZYsX30db3fC81XiIfUY0Uq8B0RkjFVKl3WaOLsieoQ33xLrmO1b3pcl6Py0OtKE+G1YUhiv3+Xwn4mPsZJI3Uw/79GpCxABObnb0Eg6WCTdjg48sNXaDo6Iln/qHUnhfI+jjQ13ejdkZjZOxvpg8B3UPgz0Ro3NVXGY9Er68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521153; c=relaxed/simple;
	bh=HmWJ+arhO4Sv2EIkKjlelBkQbd5k4cmf5j3kuYeCtDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPp4apDUKtIP9CQ0p+m+DHFJNbCnchqAF4lQ04mFnkYtlbe6+E+vZJLAPILVpR51dZn1WQR7fYWVTqKkXV4H8+8Y69eZyRfNTjoHqkQ7+VQyNx8xze2qdHUK0gsZBtLYKH2YYnosNAHdcIdhpNxODcwZPFyJSIpXSYad2+okUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBJj3yWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B24CC4CEC4
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725521153;
	bh=HmWJ+arhO4Sv2EIkKjlelBkQbd5k4cmf5j3kuYeCtDs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oBJj3yWFsAvYja/rd8hhoYrBfglhKFhlzs/h7BejKNYvqiDLhhykFDtrdZJhYOJjU
	 ArONcppHU06D6yFJ2uNvpXoa8Hk+zp+FtgVU8DbSs98pOnXWmacgKpdSE+OX5g47GJ
	 gToi6aEf8kUM75TFQwNBM4wSqm+DL+XeeRoP+36fibDTEBAQwM535cZKnB9kM9suZC
	 SkLeR6IsYQnjWqLyIE9WL4XOEtRCcp0La25yl+tny0GynUhVTBhUwt135Glvs5ZiY2
	 EuhcBjTLInlLolvvSkOFQe7X9dm+TtKASvI6WmB+TA/b9Rtwpn0rZWG/GwqEOm59pa
	 tl7T5N88tzdtw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2A8ABC53BC4; Thu,  5 Sep 2024 07:25:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Thu, 05 Sep 2024 07:25:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-rqQvdccEby@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #12 from Richard W.M. Jones (rjones@redhat.com) ---
Is it possible to get this from 'crash' utility (ie from kernel structs)?  =
The
VM hangs fairly hard when this problem is hit.

I can try the kernel patches though, will see if I can do that today.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

