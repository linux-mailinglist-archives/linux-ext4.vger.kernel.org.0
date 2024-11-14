Return-Path: <linux-ext4+bounces-5153-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35529C8C2C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A759B2850FE
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42091208D0;
	Thu, 14 Nov 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QNUKjZBc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8217C8B
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592429; cv=none; b=LyWkDAmeniEo4x2/rKMU3+25/OD+XxKS7Uj8EB/3ix3B1RTo+xfKMtqb8YRqyqBO7oTMclmaF6Et0L3c1Se/+rTTIsWRmhQoRnx37HxuoxGCfJosS8OILdnhDlOl7aGkSvIFFJmo0isuicdQ0np9LD9ndaeCEMTvMTtUWrh2P/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592429; c=relaxed/simple;
	bh=z3hbkyASjwVUxoo3ofxTCaTvwqr6OL5hHbibAw4xX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJhIt05TWSnV18PZm1ugr6Qp118/6nDzKhTmZvOr3vGiX63hDyhDZlUIMKI3AxVyBzRO8rrxS4csr7Tk9Z3JdBqjQYKBL4zLw65S6Uk2OX802bKR8S/Yc00/slH6S9y2PWZL3mGHNN/z5sFIiYvbRDdyGsMwRSZiC4cMkTkfd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QNUKjZBc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrhZQ001789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592424; bh=6nYRw/UQwayrZmPtD689O9FiCl9PjzHWowoN4WXa/OY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QNUKjZBcEhRrrEj3zR25UXZOGZ5JRYb+i9y/nVX0UuEiox5i5AjvbpwGvX81iWs2V
	 q6zWacSwUOkYMHbbw26UaqFd2ws0MmNCp3dF8rP+kWKtkz07hBdiOb8lokOE3JZ2eU
	 y+rYhpRYvbybSP2mIefwxIjMX6o1t0Fdr8L9+B3LWDc7seyqHoWpx8pwoCgMG/4+0X
	 GQxUwuyr9Yud3d5m2tjB2tmzbZ/F9jX+ocI81AEenFuXl+WBvlztbraxqiBBTUJF6n
	 I/CzTKJpA1icyoKbPXgvb+eaCS3kblrJw6d19ZPw6UOIbjme0kcyY6wyOlEDzUa8mr
	 pScH/aJTWEmJQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 40B3215C0317; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: prevent delalloc to nodelalloc on remount
Date: Thu, 14 Nov 2024 08:53:32 -0500
Message-ID: <173159220755.521904.1520067635387223066.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014034143.59779-1-bretznic@gmail.com>
References: <20241014034143.59779-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 13 Oct 2024 20:41:43 -0700, Nicolas Bretz wrote:
> Implemented the suggested solution mentioned in the bug
> https://bugzilla.kernel.org/show_bug.cgi?id=218820
> 
> Preventing the disabling of delayed allocation mode on remount.
> delalloc to nodelalloc not permitted anymore
> nodelalloc to delalloc permitted, not affected
> 
> [...]

Applied, thanks!

[1/1] ext4: prevent delalloc to nodelalloc on remount
      commit: 97f5ec3b166db4e47ee2c0bdb0deb027413d4f2a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

