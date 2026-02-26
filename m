Return-Path: <linux-ext4+bounces-14045-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEBWB2E8oGmagwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14045-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:28:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA41A5AF1
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAFA3041A4C
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CC366829;
	Thu, 26 Feb 2026 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvFgvUl/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA804221FDE;
	Thu, 26 Feb 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108844; cv=none; b=Hk1IJ9amIrEasbZSWA87KteJyHkbm4fVvh/k0F8ivn3e8L6yi/AsNthVZio5Rohrapp2hRuvzK2oil56RPxQ7L2ZyY5fwlW0rP7affkhw9UaxnUs7+DH+udRbO7Ux5kh4VN61Z7tSuSYvp/BzXAPQmLfbe/6D7HdkjPdYgyRxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108844; c=relaxed/simple;
	bh=5T+IKcLz2704l+thlo/byfxXLDEQDyBPlzAy3ljbSP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHvIU1MlLSyJFqmWSCiz+qwWT1xHrLGzYIdgfbbF0rbZaJWGZMWMfJ0/Y3FVXldJxY6fWiLQyT6K7ZUnOzXzcsNXlSonGkrEtN8VNsBmTOd+DNuXJ2BPpEfBs59wAOrH9JXZJxAVRjzpmDB8dfZ/PwuzUGYQnekRsyBCqMGGD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvFgvUl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89BDC116C6;
	Thu, 26 Feb 2026 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108844;
	bh=5T+IKcLz2704l+thlo/byfxXLDEQDyBPlzAy3ljbSP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NvFgvUl/Gmd7Ib+ARBt25ipXp5pIiv2hgkau3BRoYATgfHu/UsUKS6MS5ICemS0Fw
	 0i70eii95alNsBRUcoszLwc3XgYjoSBa4b9jP6/SxoVW6mrd5dcaOV681+kQPNLzU1
	 EJLsEcBkHdzm96LYd47JRFokryUyWobwS2gVUQJp0KnwA5YvauJkBodP4SzNgmLfi5
	 qc8NwR+j5ZC9gRVs55dP1j63u+avEVnVtr9dIoxY5bqRShhLjXsFRs+Vl6JYffGJEl
	 JE3KKSFAN8Y59fVnENBj3W5QuzYOwUoUScORc8lYCXKZnLLVuqXsMyDRPSJ80uWlpZ
	 WS29jVsLBp/Dg==
Message-ID: <a2993605-2cdb-42b2-85fc-b071f07af4c3@kernel.org>
Date: Thu, 26 Feb 2026 21:27:19 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bdev_nonrot()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 linux-raid@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
References: <20260226075448.2229655-1-dlemoal@kernel.org>
 <5b8c1811-c9d9-469a-b8d0-992814a11b9a@molgen.mpg.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5b8c1811-c9d9-469a-b8d0-992814a11b9a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14045-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5BA41A5AF1
X-Rspamd-Action: no action

On 2/26/26 19:04, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Thank you for your patch.
> 
> 
> Am 26.02.26 um 08:54 schrieb Damien Le Moal:
>> bdev_nonrot() is simply the negative return value of bdev_rot().
>> So replace all call sites of bdev_nonrot() with calls to bdev_rot()
>> and remove bdev_nonrot().
> 
> Is the generated code different now?

I did not check but I doubt there is any difference at all.

This is more about having a single helper function for bdevs that is consistent
with the helper for request queues (blk_queue_rot()) which directly reflects the
setting of a block device BLK_FEAT_ROTATIONAL queue feature. This way is also in
my opinion simpler as you do not get your brain overheating when seeing things
like "!bdev_nonrot()" :)
  > Is it worth the change, as it looks quite subjective if you prefer the
> one or the other way?

I think it is a nice cleanup, but I will let Jens and other maintainers decide
on the worth of this patch.

> My point above aside, the diff looks good.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks.

-- 
Damien Le Moal
Western Digital Research

