Return-Path: <linux-ext4+bounces-3820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E39598F9
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CC5B249D6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8301CDA01;
	Wed, 21 Aug 2024 09:39:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF31B3B3F
	for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233156; cv=none; b=Ks/ZI2SSdISO9jALH9g3WHYBn0UJ2a6KJwJGPZBuZJuUMWeXUQT62bcpMe2F7YyFUV+a5qc7pjauovwEwT/TklIsD37tKYJwfuv7RRnTL4Osbctfip9RwmUad3JdVTkwIWY3fAdbI1aYaeHTwfWfs5uZbSZn9LxRkUKztJ6JjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233156; c=relaxed/simple;
	bh=Ao5XTqRA3oPiYto/qB4NlZFy16+NlpC8NLh3GspDrB8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TtWjWMRVjDRFYuRF/PBAzQGfjx8pXAQCFopSzMoU6q6iLecPWAfP29zBrHjQCqek8LsohAP0SKyaymf2RjIHJKzCPujNsp9pwPXzUVuGeksh+9QmOtgVmXBNEpBQVOstgCvZ6hsuWjPqSX90yuRHxV7Hv6L134AxT0rp62Prcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.39] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 228153F002
	for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2024 11:38:56 +0200 (CEST)
Message-ID: <7642a14c-67bf-4d25-b54e-419c7a650330@hogyros.de>
Date: Wed, 21 Aug 2024 18:38:52 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ext4@vger.kernel.org
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Overwriteable media errors and data recovery
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

my underlying block device lost a few blocks due to media errors, but 
the blocks involved are not permanently bad, so the badblocks mechanism 
isn't entirely the correct tool here.

Is there a good flow to recover from *past* media errors and get a list 
of affected files?

Use cases:

  - Harddisk reports read errors, but remaps blocks on write
  - Volume manager reports read errors because all mirrors were lost, 
but spares exist
  - ddrescue copied media, with a list of blocks that could not be copied

Basically, what I'd like to do is go from a damaged file system and a 
list of damaged blocks to a good file system and a list of damaged files 
(which allows me to check if I can restore them from backup, or, if they 
came from a package, simply reinstall them).

Could there be something like a file attribute "damaged" that is set by 
fsck, and that I can scan for inside a mounted file system?

    Simon

