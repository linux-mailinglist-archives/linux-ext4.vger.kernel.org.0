Return-Path: <linux-ext4+bounces-6365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CAA2B667
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 00:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7CB166E62
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDA2417FE;
	Thu,  6 Feb 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="z0yl9JsL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562F2417DB
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883399; cv=none; b=WyPyq23TZGU8P06q05fwp+d4LH1YM2KvCwsmcC/Ekpr43xPxKVh+Pz7UMqBGqkanH7E8+nG0sT5SqVdMDql0QCAD+VKRx6Sjwt71HOtibszll2sq7dL36VWabniVdakkLJJCvcyUR/ZzGEHUYOFZ1TqA7gaFFs+bYN1BFc+pUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883399; c=relaxed/simple;
	bh=kPQLaiE17kEvtVVIcklJiOtE0vJC6esAyz2PHe7aHgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx8Dw3Ya9nMymaTRicP7MLPTTtJ4q+TDnw7m+CxpG4cNHtCExVzcv2jtkMorp78DIvZfXYNzz8x8N4WeVGL7Lmsn1QA9bwwa/tZYlEJW2ytBfXrVgY+pUYLYvzFrnREcjaU27w5p3bu8QYykXaPm6gOyQxT9MXz7VwE8T6U1TbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=z0yl9JsL; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id g8yitL9I4AfjwgB0OtGRjN; Thu, 06 Feb 2025 23:09:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gB0Nt3mZg1kimgB0Ntx60c; Thu, 06 Feb 2025 23:09:55 +0000
X-Authority-Analysis: v=2.4 cv=B/i/0vtM c=1 sm=1 tr=0 ts=67a54143
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=5NrVWRCCLrfdh0Jvg2MA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E+YTnOMYFTRww4vc+3L6vgtI2NWn1P0qdxz7Mx881oE=; b=z0yl9JsLXoRh1h3AVY+uLJtw4X
	n+Hz1G6DVZbr32LccMc47/N6SN4IcKu1lFTicgeWulkvu7Iqc2w509Bgk/M6YlEZstXO5gqvfWoXP
	dIAodwRLmFy8ppN3Be5uKiRtajKK3iaHd1BKZ9g2XWiKqfNQn5hrarCjRlxKv64ynqQUBa3SxBNtv
	uWtcTIV5kARh73IG73WeIh3bCvSntiB08J9YBN9LQAkFCuw5S+qyEET7bl53wdB5q0xzpJejP8PHO
	HYDiVh6rXlRb+OLhC4HsHXCywhKlOGYZnYgNj2ZH6zvIiXgUvolo0BM4LMiV2eZAVAvDZV8Am+CzZ
	d5dL+73Q==;
Received: from [45.124.203.140] (port=54600 helo=[192.168.0.152])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tgB0M-001s8r-2D;
	Thu, 06 Feb 2025 17:09:54 -0600
Message-ID: <09e5992a-46a7-410e-a57f-3d337d282943@embeddedor.com>
Date: Fri, 7 Feb 2025 09:39:42 +1030
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ext4: avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Theodore Ts'o <tytso@mit.edu>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Zz0TEX3GycUEmISN@kspp> <20250206150910.GA1130956@mit.edu>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250206150910.GA1130956@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tgB0M-001s8r-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.152]) [45.124.203.140]:54600
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMfAQt7KXqNyjzUIqoAEIkkSVASDg7g8gNQRRXO9x2RgkntmCOUrbZ444u4nUX+k3G9w9OiiqpkDEu8jmlEOt5P378exuTbbD2Df4M0e9ifk6bNCCj0r
 xR+UaODn3qBhld+zMfwjZCnlkcnCkcErQfmAoUz7nHMhlnMyfzUnHCThtquVtn/LZlFC+OaGv8/smJ4S6sSZ+V33JvYzreXecAZH0pfNWWffpo9iFIv4uT6L


> Thanks, for this patch!  It appears that this patch has since been
> obviated by Eric Bigger's commit f2b4fa19647e (" ext4: switch to using
> the crc32c library"), which landed during this merge window, so this
> patch should not be needed.

Oh, nice! Thanks for letting me know. :)

-Gustavo

