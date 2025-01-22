Return-Path: <linux-ext4+bounces-6191-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2BDA18BBB
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2023D16BC48
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42665175D47;
	Wed, 22 Jan 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="PF869RAc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC31A2550
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526224; cv=none; b=AplXtgrVXcu1KgFRu6KteVkLw7CWZx3A8uMRF+YCIWbfPShE2SAe23JN3rwXIXvvUhRaxYomGQo1NRH7ITCOiu83K7khwUhQp6E9Oca7WL0JIxuRwGbXH7MhJMg/amKWAfDozzp6uWh0EM9+sLjiORHvPOOvxTowOuHW1b79yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526224; c=relaxed/simple;
	bh=ArG/nQupr+zebR8YQDBxcvQd2rHwYJA3MfBA0Vqcq+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh7p6W9NiDDXQgrNr/DTVMrBAEmg0aGSnj+l7X4LxrACacIL+uRKp7SfIYHgvUL9n7Ou83eIG3U2LPJVStccraTGZDsp080aosHdbfb0DWQXwELpGzXlyk6GZBukuLdUVBjVjsgSoIHOuBL7JUYdE3ZlpixBbPq/XrX1cRX8g0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=fail (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=PF869RAc reason="signature verification failed"; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id D344C9F1F5;
	Wed, 22 Jan 2025 07:10:19 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 50M6AIfA198252
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 22 Jan 2025 07:10:19 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 50M6AIfA198252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1737526219;
	bh=GZuZw2EAVElZFHE9vr8QQLKABDZ0UJd7haTDH482JPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PF869RAc1Ttxim8DpC4hgYtPrheu51ey2RLsoQHHu5mOHLnB5Q+Bjav08Gc123bqp
	 FOfNJfuQbwAWvNAJvhoQOw1nWDpHLlyWXu5jLyoEXnHgCfNJSqPw/axnkUEuKb9XsS
	 2PNuPxGY7GNZDX7Uii+47gtN+WMdyg3IdBrf0tljVAga7eStU1sI9zzM1QvEgBnXoS
	 dwBK+C0qY+LVT/r0ZCf8Lf1ZG+LkNtZWNAZmCf2BgmtCU/tPXigSbhx2Zm449jlJjn
	 /q4p6MrqbSnnc6nmPCWVtEkhFqrL5Tl5ncYEudOlPuv0Gs5GH5Vs8nfU3eEpHoLy1e
	 iQaY77RY1zKPpfr2B7SQVABIIxCky+wogAxfkZOsklBkJhlAvYhpW/0Vg/JbB26hQt
	 +Rzw9RDJOV6Y5NbS1Buiy6tQdoJszmPc9bU7wTStAYvV0Z1gxxSFCwmzMM0WO+jxb3
	 58T7ot0IDN777KuGny8TVFv98q5lbTJxQCzlNE/rATdZl7qtA64L/5N89DZCggnwTW
	 OBNI/3uT29YCVuRTJHl/SgxmJliWmKh2QuCJlp3uGLqGxW9Qn2SkAtjIxC/98uro6F
	 b/rCX3AvkzTYuW1+xfYxK+0QIE9zwaviyZ2nASfujRt7G14yY5rCKs+7NIFElWj3ej
	 ohcU1yee+L3UWiqXCJn8SRSA=
Message-ID: <10e99b47-2978-4dbf-90f0-750c7fbb6064@wiesinger.com>
Date: Wed, 22 Jan 2025 07:10:18 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Transparent compression with ext4 - especially with zstd
Content-Language: en-US
To: "Kiselev, Oleg" <okiselev@amazon.com>, "Theodore Ts'o" <tytso@mit.edu>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
 <F2121024-62F6-493E-988B-FEAD8E4A33C2@amazon.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <F2121024-62F6-493E-988B-FEAD8E4A33C2@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.2025 01:19, Kiselev, Oleg wrote:
> MySQL, MariaDB and PostgreSQL do their own, schema and page-size aware compression.  Why not let the databases do this?  They are in a better position to do it and trade off the costs where and when it matters to them.

Hello Oleg,

Thnx for the input. For PostgreSQL: AFAIK compression only works for 
larger tables (e.g. >2kB) and it looks like it doesn't work for my usecase.

But will have a deeper look into it.

Ciao,

Gerhard


