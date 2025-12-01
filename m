Return-Path: <linux-ext4+bounces-12109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C3C983DF
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C5D4E1A63
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B1334C09;
	Mon,  1 Dec 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OLhd9AtK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89A333452
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606508; cv=none; b=QjKZRhjQOPxOjkKuJ98K6Qp6f+BcumgAtKSJ7Gkuy6OUiKiuiDDGcMwgduiy3e+A0jaiOK3Ep+CWsRuGnM4toVmqWpOwfIPDUGakw1rZcfcwhN3knCognkHrXCo2rgq/Q+zi2EyoGXkAizNqlWmnQ5rt9zCfWbLXyf6muC7vX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606508; c=relaxed/simple;
	bh=buLCI8wk6RmLtGJP8jJoPXBelL/3Y29bbxzjKLxGobM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKVNR8t7FEmdUP2fy5GM+M2hnOdAljZlIvyEeAswAKwUUHB0k152chdpnM4gGJDhRWdqaRL+4dKndi8QNWbQY8O4tu41CZO+WY0VK/GyWvq3nKinEMERrZ9s+F+a3ev4Qxiware3J2KRKyXedGM+wwn6XSlLfUfIGSJ5efxGQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OLhd9AtK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNsmb008174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606236; bh=fQo4vd5KQhxo/ZdGnKAc55jtiATNEP6YCFuef8oibPA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OLhd9AtKgyOR+f0BNNOajkWzZECWQyODvKaeFFVnrBO+dNH2N/5AP7IqtA1wQZbJx
	 BqtULqF/AJl8OkdibXmUVyyIs0rjnmKJac11utY7bjczBcmDyld2OmrpDUnFwFs0HW
	 b3WqLhxSOQOKXTRJyUJvNDKWzpv6OCORRiYSDkpThdl6Wln/cbzV6aMWa/apjBOV3K
	 RqMejZMUl3k+lLQSY7KgAd47f4zQ5L0xwsop8iVe2elH1FhUVu/bLwX781VHy0bc95
	 e7dZiDqHE9nzQo65MDdPjr9EwV+/gzZ3Zz1ZcumMzR6jzc9I6hzNgWKYd+ZqBMu+GK
	 qGxfZv3AMXhzA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 042352E00DD; Mon, 01 Dec 2025 11:23:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Yongjian Sun <sunyongjian@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com,
        libaokun1@huawei.com, chengzhihao1@huawei.com, sunyongjian1@huawei.com
Subject: Re: [PATCH v2 0/2] ext4: fixes for mb_check_buddy integrity checks
Date: Mon,  1 Dec 2025 11:23:47 -0500
Message-ID: <176455640539.1349182.12240095790496691411.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060614.631382-1-sunyongjian@huaweicloud.com>
References: <20251106060614.631382-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Nov 2025 14:06:12 +0800, Yongjian Sun wrote:
> Link to v1:
>  - https://lore.kernel.org/all/20251105074250.3517687-1-sunyongjian@huaweicloud.com/
> 
> Changes in v2:
>  - Patch 2/2: the logical error in the order-0 check code has been corrected.
> 
> Yongjian Sun (2):
>   ext4: fix incorrect group number assertion in mb_check_buddy for
>     exhausted preallocations
>   ext4: improve integrity checking in __mb_check_buddy by enhancing
>     order-0 validation
> 
> [...]

Applied, thanks!

[1/2] ext4: fix incorrect group number assertion in mb_check_buddy for exhausted preallocations
      commit: 3f7a79d05c692c7cfec70bf104b1b3c3d0ce6247
[2/2] ext4: improve integrity checking in __mb_check_buddy by enhancing order-0 validation
      commit: d9ee3ff810f1cc0e253c9f2b17b668b973cb0e06

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

