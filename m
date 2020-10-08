Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22043287CE6
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Oct 2020 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgJHUNG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJHUNG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 16:13:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED38C0613D2
        for <linux-ext4@vger.kernel.org>; Thu,  8 Oct 2020 13:13:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b26so4904535pff.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Oct 2020 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=okbiQiFQWt/1O3IuAnTeexDlQgzCWkXknnLH8yR2DPE=;
        b=ZZgBY/7tIqMX26BzIGerJHcmm7EyOAgjYUax+R51ulojxFCsTtbfB1UJaj+Rf+GKS8
         HcPNWCXOmuBbwpuwfjlhTQb6Yp1va4oGOm1bPEvGvl4zijaWYrD5lbVENbtHK0tFBY3Z
         3jmLV90eNHR/hZ04BpFT49m8Z8xoXwD3jeVoDFFHyZ6JIjIrzprN0qlf7Z6srfhGwd8b
         99LBRS1aae/X3eyxjKiDeAD3OhWCIl/kXLFx94B/p62A9SORaAvZadQ7yGGzhR5E8F0T
         ToGTrLl5w4zNb/MqmmG3c6PDVtomENWFR83yX25oURzBx1WrlEzSVFycqVRMRVuTYnjU
         LoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=okbiQiFQWt/1O3IuAnTeexDlQgzCWkXknnLH8yR2DPE=;
        b=iFtFjCkxun5bCHAogyXSJEAq7LwagiQtw2nMPKbTxlpaND0icdurIDozTIIroS3Tph
         jKFa5wCjPoYGwzN1zNqU0rm84kMPV+jOuQF814kCS5TcgXzqk8hcbq3tO0rf7GHzTfTX
         KT1ht45SJ1FK8QvoiP4MFal9y98rzcZyRm9pLtmiEERCHzt1ZRJDv1QAf8qPDGyMEsCl
         s/WscZszroqn7bLl5/n8LkMWtY1Iwsk7aNyZ2zA6xXz1nvHNKybFgHejxdkX8SDadxJo
         6CgD8NkA4/2CWm9VLY5ISoVAFI/5SIEU75rfk1t3g2KucSsANbT9OT3xZb/W8VWhqyI7
         OwBA==
X-Gm-Message-State: AOAM5310bLVTYi5uEfsOmEkr/QppuHDUu7FflE9cgU5FprzAzgEhBhzg
        qCP6tW4lnHlUnneR9Ve3Dzd01DJ8/Ord1BZt
X-Google-Smtp-Source: ABdhPJzsCCMaGdimxrMACS/kbM4auNa4wvooJZAQ/Ln8MHZSI/t2ESFeheuqI/oOJPy9LFPpKJQ0Cw==
X-Received: by 2002:a17:90a:400e:: with SMTP id u14mr611382pjc.118.1602187985591;
        Thu, 08 Oct 2020 13:13:05 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id r6sm8020103pfq.11.2020.10.08.13.13.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 13:13:04 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AF239FDD-1550-4D24-B2A4-C015689C9203@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_29227FE5-8379-4A0B-8C19-943775F8563F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] jbd2: avoid transaction reuse after reformatting
Date:   Thu, 8 Oct 2020 14:13:02 -0600
In-Reply-To: <20201007081319.16341-1-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@hikvision.com>,
        changfengnan <fengnanchang@foxmail.com>
To:     Jan Kara <jack@suse.cz>
References: <20201007081319.16341-1-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_29227FE5-8379-4A0B-8C19-943775F8563F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 7, 2020, at 2:13 AM, Jan Kara <jack@suse.cz> wrote:
> 
> From: changfengnan <fengnanchang@foxmail.com>
> 
> When ext4 is formatted with lazy_journal_init=1 and transactions from
> the previous filesystem are still on disk, it is possible that they are
> considered during a recovery after a crash. Because the checksum seed
> has changed, the CRC check will fail, and the journal recovery fails
> with checksum error although the journal is otherwise perfectly valid.
> Fix the problem by checking commit block time stamps to determine
> whether the data in the journal block is just stale or whether it is
> indeed corrupt.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

NB: one trivial formatting cleanup if patch is refreshed

> @@ -520,12 +522,22 @@ static int do_one_pass(journal_t *journal,
> 			if (descr_csum_size > 0 &&
> 			    !jbd2_descriptor_block_csum_verify(journal,
> 							       bh->b_data)) {
> -				printk(KERN_ERR "JBD2: Invalid checksum "
> -				       "recovering block %lu in log\n",
> -				       next_log_block);
> -				err = -EFSBADCRC;
> -				brelse(bh);
> -				goto failed;
> +				/*
> +				 * PASS_SCAN can see stale blocks due to lazy
> + 				 * journal init. Don't error out on those yet.
> +				 */
> +				if (pass != PASS_SCAN) {
> +					pr_err("JBD2: Invalid checksum "
> +					       "recovering block %lu in log\n",

(style) should keep console message strings on a single line


Cheers, Andreas






--Apple-Mail=_29227FE5-8379-4A0B-8C19-943775F8563F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9/cs4ACgkQcqXauRfM
H+DS0g//dEl1VvDNDBSu0wZSiCx0r1y4qblGoO7xAEsK7MdtzVmjSFwRyB51MpgX
ceJqbHGgWX8yetk+IozZI9M3rW1GlcNmKgSvhlocLk6OecRw8j0G3AWLwx4eklOC
5ErHPrbauki7XGuR2OuzP0lQ3fsVDT8eDfMCh6ZGEhikhOiM4exngBMe6zwu8/Ua
WEQL16SRdeTvXd3yc0iup7CwXMeyLyk3vygweI+aDKJRz93xNXlaLNu0I9B9/U1J
mChwWm3v80bMEPabMzaS09nUiYYe+gNdMnmW+J8sw+fATgsDb8QXLJzamAICn7/b
Vhn/dCb9cZJtQcinFjGGTMPyv8HsqhqyadntCa6/AnYsfTp80wyb/CQyVSYwNbHq
6h1c9SsCdiCZHK687rNluyloBa0qOLuYmIYgxLxmS/HV+kre04a5rPDDNdCb0w+T
TAUxw1DYEX1iIsIBrrS+sdWNmSycpLuRxj+bMSPGWy4i2xspVsZugkLzlI7ufodG
9qx1nSJ+29SsPFk80SbEVWqcdByX23/mmCAb3fc1KQ+drBQDXHYcQs+0xvGshurO
xtu23LKtBGWc20bJWQfA8Vb7Lg5jsLomMxSWErhspJUkf0pYog+F2RaRA3K9y+mW
BMfoSjgOtdFEIBn1OBaJkVXluczVoOoeY2oRniMt2FkjlIU/dQs=
=uzvs
-----END PGP SIGNATURE-----

--Apple-Mail=_29227FE5-8379-4A0B-8C19-943775F8563F--
