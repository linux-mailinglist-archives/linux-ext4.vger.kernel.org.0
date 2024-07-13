Return-Path: <linux-ext4+bounces-3242-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014139306ED
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 20:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9AC1F21C41
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2413D8B1;
	Sat, 13 Jul 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iHm2hNhO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E9F49628;
	Sat, 13 Jul 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894572; cv=none; b=j9mqaAJ4IqmuO7sqoQh28N1FFCG8NIlnFcFByBCuTE2vF+V2UKukdD/ME5VEkccEJkcxLNjxIfT5FBe41APmA5xTdohMu9nEQMhgF5+hNydr61dN9YunxTa2DOaCc43NhpxL/W22iXPhyL35qBIN58aZ/KgyMELWryyUObIxB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894572; c=relaxed/simple;
	bh=abtA1WlSWwOahxLlGsQr5aL7NXMTChi3xnNxf77tIbI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AWjd/t1LFFDibQgAoH7+GiTAe6dYizClQ37R+wiFkFSqq5384lsbCQ6cwN64u6hcMUDUY9IT3xRNEQRa/Qeb5o4irSlTNus8GEK8abiWnrZoNSLostVGl1jXQaPCtYXFJOqxtKEho9br2bwVFQVTv1ct/hoPhH/soAImbbMAj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iHm2hNhO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720894556; x=1721499356; i=markus.elfring@web.de;
	bh=XttxvoNiaxIVA1/LMbTGUcLFK9uZmow/zywISsYZatY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iHm2hNhOUpVb+ZGoZ3mw/07/F3/GBi6tzDhiMX1qLbhAOeFimEjsJQzbIrC4BMQH
	 FLnV15Lp+zALTlUwq789RhCjE9KDY4x3YNglSTj6csX+KMUujY9yYiFh5pQOwJSxR
	 iHWRufM+4VUxPeovsrlYqqPBbXEtbg+sFuW8OxRYbpQ5UQqBEfsaGh0lWX1fOcE7a
	 FwN0M4nnt5cm0VnskE52/5Ljnvu4H11LKMXjrxYxYENHT08Q2ktTW+0AGI6xycwaU
	 7xxJ6b+w/RCcdiTIexFYqgpVZYOZeRVEJAy6UaKnXaEl5qDjsUfnSa332oSdrZEUM
	 Zye5k2ZDmT19LzbOQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1sTWMl0LFH-002aAU; Sat, 13
 Jul 2024 20:15:56 +0200
Message-ID: <076974ab-4da3-4176-89dc-0514e020c276@web.de>
Date: Sat, 13 Jul 2024 20:15:44 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ext4: Use seq_putc() in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mA/biMw9x2cevcu9rqUxz7QuOs6YUA30/RlTyHQ7u04jOV6gwQ0
 Pi9ToAsTYLcmb5p6NJ0jZqSZ/2m68b5Zw8n6zhy6UWh64UGNP+QLDQRwRpD9umHqpTOOGAu
 AgyzQDoPERafNEiYOLyeGnykIW4zFaA6IhDBe7YbNLdbPWXc0lHiiZbMGe7goOpK7+SFyJj
 9soFVFjUNyJrIs4OPu89g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zPKXLfg+ezo=;+G/iDIXEFugqd+cvAYOe9JHg/9t
 ztwRtOJvuSptQ6kyGgoDbsbmge3hHGHAkgOjUP9HEmS2g9htC9mfiwXrGkWNVfZuLTAFtGAC6
 3BGJVzhpeNASgugBWo0TFhcpp3XqkhpfyN1AvfzLNwaD1XteaabrFcbgdrOm0f/Zo50lJFzOz
 6qv5N+7g+qwsvJ/j8yFhSRsS/ktcuhoMgNUnCB5f62B+HRFMa/RelrbDR1mIk64799xYb4/Nh
 4zLoOQAATYF8DK2klKpbyWVhLwd1ZZ9e06x1Sv0Kh39bv3ifAWCG2Rbp2cWSe2X+eqUP+E3O9
 TdfgKX2rUvNAu9DpJT3xxrchS4zWK5wwMdTaPQic72ty4OLVnPRuMhDLOxKd5yb64rOrvd+ew
 Zl1ebvgGlhrygXYQfEJ78x3xFxLdvK2e9awqMLb74k9mXYVX8CZIWp3OLWJbw8y068GeIgxQP
 npNKw6WvleBmINEbtG14N7t26UEJYfaJt7HkEkxCFjFwq+d6a+OVtgQ3/5Znq5T3upTUSPADQ
 B30O0f5N1Zsl1zB0FDDPV0BxctmcKIP2YVMQuQnRpWV0jXgr8oc/tiygWCCScBwjUeDeaS99r
 SABSKx0/tstZdGaMORXolvKxSZz9T083CJzU/KNoNdM1v8ZSYMSCKFnZvDpBrznYmvrLkLiSJ
 TW8aJiBqlpdLMcS5pnpx+5SvRdZ8R/AFWpBiJzI4cpfW6u+9CQF7UIltBzzJeG1NaD0Ml/g1Z
 MThP3MUTRWvyURTPlIFe0WebculEXkNn9dTC9+bJnng1PKCPkeoxUGEsORfY2os4FhjxQMWiF
 nRos11uvaemmWZmqKChBpEng==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 17:10:24 +0200

Single characters (line breaks) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/mballoc.c | 3 +--
 fs/ext4/super.c   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..2008d2d524c9 100644
=2D-- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3075,8 +3075,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *=
seq, void *v)
 	seq_puts(seq, " ]");
 	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
 		seq_puts(seq, " Block bitmap corrupted!");
-	seq_puts(seq, "\n");
-
+	seq_putc(seq, '\n');
 	return 0;
 }

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..c8a80cec46a1 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3045,7 +3045,7 @@ int ext4_seq_options_show(struct seq_file *seq, void=
 *offset)

 	seq_puts(seq, sb_rdonly(sb) ? "ro" : "rw");
 	rc =3D _ext4_show_options(seq, sb, 1);
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 	return rc;
 }

=2D-
2.45.2


