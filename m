Return-Path: <linux-ext4+bounces-5897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007CA027BA
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FF0164F08
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF81DE3BE;
	Mon,  6 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pMlVJh9E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0861469D;
	Mon,  6 Jan 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173225; cv=none; b=ppLr8OTJnZglixHAr8mS5YpGYQLlfTnsgOaHMoP9N8pb4RgTE7tcRef2DDTR7vFL1pFlKTxGrvbyfMPHnuXzCYangpi8UoL3HcmdcZnIYU3vAnD9H3BX7eSd1Z1LosVA8BnG7MeVlmC+pxgxVmFtIJ7bPcOviHOwm9746ZMs6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173225; c=relaxed/simple;
	bh=H3o1WOzrrk23WPvGqo0oelniBWiOET0tWoR3lHnPCS8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RVGBD3LOYFgOqWfMpYJcpU+hG0VPloM8DxbKIcwYrCVIijx0YoGpkE/5VwRURnxcvQJvy/hGpm68UfIttDkwVTpoYmnEgW6/eaoKgP0A1LZOie/2XTmPj729EfHj36itaPmK05FadNHM5erBX92IHhYZPINgmZwnyPFFjSbmdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pMlVJh9E; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736173215; x=1736778015; i=markus.elfring@web.de;
	bh=H3o1WOzrrk23WPvGqo0oelniBWiOET0tWoR3lHnPCS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pMlVJh9E9HpdX3+g17/d2eMevo9pUfUEpJNlGip6LTFEf/Q0FG66EwID6Q4pDagm
	 5S5AILx7ZEZFl4W6GaV6K/MtBi+FJNIRk/cAf7dfCTKasACH2vIK9SYtFQfSxQnSC
	 2lXI65/1qOOvjxiDJ5GY/pAYIPZfWyfhjFrJBluUxHaZmNH7aPXOfw90wTQ5XzR65
	 fAAwLsu2xxdO4O2gKbP1RBTjgRNQLYouQxDq3cOmuO3uZV5lWlBxPIZ/C11yrtZhU
	 Upc3/DUXoXtW+w6ZpyBDTeuSZHjIwTehlDCGQkFuRBIj1SA3huXPeKQ6fQDsVUu5D
	 uGs9rR4scyXv6mRB0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.38]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1u4PMW3XwE-00caRS; Mon, 06
 Jan 2025 15:20:14 +0100
Message-ID: <544231e3-a355-4229-879f-d5ed4a5130f2@web.de>
Date: Mon, 6 Jan 2025 15:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Theodore Ts'o <tytso@mit.edu>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <282d130abca6fe7db5edef1922c971849397ffa9.1735912719.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] ext4: Remove some dead code in the error handling
 path of ext4_mb_init_cache()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <282d130abca6fe7db5edef1922c971849397ffa9.1735912719.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f7Rsa4GrcbI+xlzCvAEiR3ihuGYq9AmQfrd7aCsqvkae5ZlEl45
 36dJ2bIOeF08N2uzNhS28ulpZpnUQR2AJt4a1AeX5YyplhuzO5HnNYZo13hocf7TL8DGkkM
 7DNZyaWTu+BurU/HMGNwJJKTeXVlRWkoTgWJmk87TXWwojUbumzVXSYzGyCSb9gehSntIEb
 GwQeSG8qkTHE5p4IcrTLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LaIMWPJlEXA=;mJgtnXjeXCT34EkzHBcY8ZR6XXB
 2StUVO8aG+4RLELd2fatNt7joZ5VSCqHkzG02iwshfTbQ7rmoIxnSgUjoLO3s90bImb4M+/Ip
 bzOOm3RzYcvwRvkYFHd3wDymHw9fRvTpR+v3oQVEwobKmShXDGBSidLcHWSk1Hd4oHqDHdWa6
 h/YlRNGV3q7vqSXKRFbXqrq2AWMLeUtZomjybIVEjXdZyD6LDxgoVfzFVUfAS0oKXYOSZZjnN
 t6B/NsOGQxuPMxCD5xbqlsF/Wvn3H0dkKWAKWhoG6h0OuhYcWvCDbzJVpjB1ZeMIhLP4hMxWF
 1ot3GPkFy/3ypln3LVyUMF7cuy6hFBQUWOOJGy4Sp/m2XmzAOitJhEvldYTXq7L2dJcwZIof1
 +bqJUA2nuxCYO1q+ylHnB0DFXcpYwthGalRrlrjGsAYkMOMVGNCTsq8f+LdUmps7bPVnHX5Hf
 CFq30sE02JJi8N1t+QpDQ/oK6WQxNOaZjZgkxiN77G2HYqi6UBpsYv/ABCOJoNTkORIJoMJy+
 ldKEYtfsMT+nzXXbx6W94yFk5pnw/IhJ/HMisRazNuZQfr/3yz0cl/c68oQrKuZ82Zpvv9PqB
 yGRHcbXhJn7C4WKUAd/7JT+Quiu0w4WTrdROl7wHk+PO3/bHRmfwSB6esmMqO1nB1HnHf6IV/
 zZ2IgEhSxlt/ZEbyIK5/xgnF+BMq4E/ePRZWAqOLWR6x29eiuvsRchfDGLwWd2gOT/vkIpuiS
 /Wh0GTeifPWb9cWyljZfZynSXoFWA1hBsMUrbL8NAX9c+1Jd19iqjXrL/mdKdoP5oH7icSyCb
 z8oaw0BNo6Hie4XzU8QZ3HeEM32PNCZpgGxf7ejbJaAyxXi1fZfC86ccNjSNngxFc/4IkQW4b
 aqHY9gYHILo7khL8wiWLuDq59pFPaKLOh5Vw4g0IkPOI7hpvH23eYqfw2Xv1MEKl1zfrfWdvp
 Q5HaprA90WKuCaIJtGQMyTcGDvIh9ewcbGN8mue5s0CezPS0nteWa+nddHge62U6C7eKmoKfO
 jCl3SFIgRDRqIf8YENa5c5tArBr1gPLxr8YEPiABh9TH35guyn6Dxj+ESCoDY9qcKz3OKTaBc
 Qn/Kff2T4=

=E2=80=A6
> This slighly simplifies the code.

Simplify the source code slightly?

Regards,
Markus

