Return-Path: <linux-ext4+bounces-6152-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52413A16232
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jan 2025 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B23A3CD8
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jan 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA61CEEBE;
	Sun, 19 Jan 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="IP+Faa5l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9C10F9
	for <linux-ext4@vger.kernel.org>; Sun, 19 Jan 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737297453; cv=none; b=dgLM8m6SUur+smGK2l1XavCNlIy/nV45ZLl1JHWBlSlw+XpENEQ62bJ/hoaX2rVOyKqrJt4+nCN8iDphxs9Q8WKX/F9mz8mHIPjnzsC02k0v9Fvz7EY2h21HNz/XlhAmnd61h1AfbVn6sxXD/MnLPsBWupeqiO1aLWup2vReNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737297453; c=relaxed/simple;
	bh=KF5PN8TkH2Uoyu1GHAI8vnd0ayyB7zJsyS6ap/0I7aQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=lyC9nLcDS3p9saIvDZeTbC0kiXKUg2w8DWCzwjlNBqDpHvgQF6lL1SV1TvM8f7EkXNiibpnizpzB3aH39fKkLUnQgHgxpFDgVgpP+l3hsGpMkRxcB6q+Lv3gkmZVB9w4He8XWBLDzPIT847WV93gYOUtMhBckgOLRSoWqOFlZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=IP+Faa5l; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 4D0389F281
	for <linux-ext4@vger.kernel.org>; Sun, 19 Jan 2025 15:37:30 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 50JEbRrQ696486
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-ext4@vger.kernel.org>; Sun, 19 Jan 2025 15:37:27 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 50JEbRrQ696486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1737297447;
	bh=B61gPWbkDo9HO9fK0gCXjCmnLy3ta7hqVCSPtXxOutY=;
	h=Date:From:Subject:To:From;
	b=IP+Faa5lTVFK9Eh5g1FVLiQuDEVhbvJBJ7bbGdlAXgbqVYOvLpAbYZe2R+tAgQ6Q2
	 Wwxona67GrPhcVNNw3dinkliiDup8one3r2tBhZTEMHdV2vTOt0ZXIbVVOxt6ssEBF
	 T3//KoWQtYqcdmk4qP/wu4z0LirDCXaKhomfDH1PwWTus0lsB7EcGPc8We63GEA2ob
	 mpQlsoh6qAiXvnOmOripg8BTH/tlhbaA7IVxgESqHz8GyUZm/isk3iAFwDzOJHyoin
	 XkjogiPok9s5W30+Y70RQpldnpB3SXRpvBT6MTYNMVQos16ma3kCaz7tegpBhqJLVV
	 rZ29uAZ8yN+FxqthZKjn7/ls8EO81Eilp1lgA80KgsIOLd/WfS27lBIqw+/YzU1oRg
	 Lm5t9P3tsraiL6M3K589AeJK2wscn5aHgKez6ffarIEI12OgQ3ktBrv8oVJTRIHU4k
	 hTL0gZgPQXIwj5V4P5syvP1YpeJ/5tXx0ZWkIUaKuE1Hdws70wJH4bBqGtAPhkhb+z
	 k30AfEaEHIhXFElKZy3tTO4FKDoMOwBtxwSLt+oZerVg7qepVnX/3tvlj7gNpHBYF4
	 uVKNRVkEImK0tNVhe0quwERC5GIbfoypeHADe8zPispfVS6hFvBBKP2VpB5m1FNUZL
	 6lCwLY2g6fEQjwSG1TlPGo7g=
Message-ID: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
Date: Sun, 19 Jan 2025 15:37:27 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Content-Language: en-US
From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Transparent compression with ext4 - especially with zstd
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Are there any plans to include transparent compression with ext4 
(especially with zstd)?

Thnx.

Ciao,

Gerhard


