Return-Path: <linux-ext4+bounces-11883-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A61C65EAE
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 220DC4E99F6
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DC32D0D1;
	Mon, 17 Nov 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FI3970gQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288E331A7D
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406867; cv=none; b=fBZRUZo8k7vsGhoN4EemmxHrERXX+LDt8IyKk04cfjceudXABIUkVZ24F5t87XmQyx6vTUza0S1K6limZhOaev3yXa3zU/ex7klGNQYfAB9R02V5yJl9voHglb1x2pPrzsGSK/Lc9WAEIFMjBzq1A1OMl8RQaGjgdW1bmdzwLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406867; c=relaxed/simple;
	bh=E52Fqa9mgA47M0jVrYYh1EhOW/tflIOD5lHoa6eyJU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R69IaONzEow7Uycer6g35Rv7QRUHFOeDbzHaZ0kSN1kG0OLPgXFuymgPPRtVwMbOJCyJWTCykDEBQDDlEctVFHUMofcbU5c+zCJlwfaALlXwk0STtr9Vg9gylVy6Qyiu2dyoB17YRF5K7Ifw0hKrstNvZ/GuCp8WFPl5DqyvgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FI3970gQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDo8I020574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406832; bh=eM3T6CDxUM3haiwmx7F5ogn5oDynnEoL4DfS5RNHYqU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=FI3970gQwHbpzPXV0LYvAr2pIeRc6vM45cqcTFp7yrsQUhtcOHfkGsFqVYHrwOOhw
	 fYz52C5OwpFpS8KK7HgurM2qDjxRrNXOmv1t7Ucf7uRqEwO+itXTEXzgxI5GQFAvTd
	 4qokNWI/L5dw/BvOg+M3IofgBqfn1T7+Kg/fRT+d136WYWJmxE1MF2YBcuP61gXs9u
	 2S4Hr9bMczlsOoOqNqUWfjor9+X1YV3yzuevLVVcnDz8JdfuOizjY/n6zrt1WKrlsP
	 ZFHDZTk/iTzPzmncJGWWnF8Hg2XnVEyYs8aZCic9C9hlvp4etNF9kEjOiyE/UgsiS3
	 eG0Zxr65276VQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3D4592E00DB; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: Re: [PATCH v2] ext4: refresh inline data size before write operations
Date: Mon, 17 Nov 2025 14:13:32 -0500
Message-ID: <176340680640.138575.9087089832680529039.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020060936.474314-1-kartikey406@gmail.com>
References: <20251020060936.474314-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 Oct 2025 11:39:36 +0530, Deepanshu Kartikey wrote:
> The cached ei->i_inline_size can become stale between the initial size
> check and when ext4_update_inline_data()/ext4_create_inline_data() use
> it. Although ext4_get_max_inline_size() reads the correct value at the
> time of the check, concurrent xattr operations can modify i_inline_size
> before ext4_write_lock_xattr() is acquired.
> 
> This causes ext4_update_inline_data() and ext4_create_inline_data() to
> work with stale capacity values, leading to a BUG_ON() crash in
> ext4_write_inline_data():
> 
> [...]

Applied, thanks!

[1/1] ext4: refresh inline data size before write operations
      commit: 892e1cf17555735e9d021ab036c36bc7b58b0e3b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

