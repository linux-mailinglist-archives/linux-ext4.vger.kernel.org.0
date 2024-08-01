Return-Path: <linux-ext4+bounces-3590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB1944459
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 08:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4E1C22303
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27BF157E61;
	Thu,  1 Aug 2024 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b="ai9IXXGT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from spornkuller.de (spornkuller.de [89.58.8.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A228379
	for <linux-ext4@vger.kernel.org>; Thu,  1 Aug 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.8.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493109; cv=none; b=GN8wyMgXDeI6jOCAJU5PtaS3pJPC5muhxP00Wd85yjuzAV6cq7nVgzM4WdaTg5u/sSorBRqwZZVsc5xzMMpVSHQ5QJXaI9c8MQwyf2bB8MyA+CAaL4l84+ZrU0FeM9HVTNHh66xJVybyTzXDKKPXKU46rYV/unOvjYKeBzfxnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493109; c=relaxed/simple;
	bh=avmFWRU+y38sBhrFGIAtblO78YRuwiFY4dEKSP7Tij0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjEYpbf8vEP9ynCg9T6LLosx82aXtcO9ZDhQMR74UYxuPo3qnbRUEA2zP/MB77LgHAY41kbHVXnHH8JJklTv31ZJj19QXaTmNhk2s5qbOXCTjy1F9VP3nCYNcminR88bAXLMzFaKWeRV2F2Oad9JZLScKfikVRKGnngc+tS6TG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de; spf=pass smtp.mailfrom=spornkuller.de; dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b=ai9IXXGT; arc=none smtp.client-ip=89.58.8.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spornkuller.de
Received: from [IPV6:2a00:79c0:74e:4001:9dcc:927a:42a3:4b74] (unknown [IPv6:2a00:79c0:74e:4001:9dcc:927a:42a3:4b74])
	by spornkuller.de (Postfix) with ESMTPSA id BD70B636FCB;
	Thu,  1 Aug 2024 08:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spornkuller.de;
	s=dkim202204; t=1722493103;
	bh=avmFWRU+y38sBhrFGIAtblO78YRuwiFY4dEKSP7Tij0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ai9IXXGTE61565cNx98UyEvhlvz4J7jdvMwSdS3RDHEBiPvv5OoyvIdqOtzUZ0jKI
	 0g6kGIBpw6TgYJBXbF0Dmrs5wtPp4zcuPNBMNhmA0tI3wMNCPFi7GHLRpuSaH6F8Yx
	 rowShNaHbcSzrQtJH5/lfG/gPl/1V3angVu1hXIRRUyCFgYbM5snBp/dz7/z9X/Wxp
	 TIYCxv7W2sNZMPVoSpXIY7NZN9gEJGRV+RTuP3rEsFPWfnwApcQyQrUfIYizIyLBiQ
	 gq/12SgN/YIhdCzh7cn1J1+RjjPrGlLm+IRFtPtYk1OEdDEvXSqKCE2PRSAp57RN25
	 DCfYDr/gxXTwA==
Message-ID: <bdf2626f-580a-4af2-9fb0-5e3ebe944f95@spornkuller.de>
Date: Thu, 1 Aug 2024 08:18:23 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modification of block device by R/O mount
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org
References: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
 <Zqrqo1lIrsxdm7AP@dread.disaster.area>
From: Johannes Bauer <canjzymsaxyt@spornkuller.de>
In-Reply-To: <Zqrqo1lIrsxdm7AP@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Dave,

thanks for your response!

Am 01.08.24 um 03:53 schrieb Dave Chinner:

>> Is there a way to mitigate it?
> 
> If you want to stop the filesystem writing to the block device, you
> have to set the -block device- to be read only. At this point, the
> filesystem will refuse to mount if it needs to write to the block
> device during mount.

But my point is, that is what I am doing -- creating the losetup mapping 
R/O:

# losetup --read-only --show -f image.img
/dev/loop35

# echo foo >/dev/loop35
bash: echo: write error: Operation not permitted

I.e., the block device is write protected and *yet* it changes content. 
This is what I find so extremely puzzling, that the file system should 
not have the capability to change the underlying block device, yet it does.

Cheers,
Johannes

-- 
"A PC without Windows is like a chocolate cake without mustard."


