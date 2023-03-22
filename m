Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CF6C58D3
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 22:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCVVek (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVek (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 17:34:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E7F74C
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 14:34:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7so2662418pjg.5
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112; t=1679520878;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cf5ZrocLuP8eawgd/E60BNCFQFk3YmpTvolIL7gKtM=;
        b=faeZG4hdCo63xtvEwQPUpWCfDvsFDutyznovvy6/bZ98AS0UU71WEzQGJUR7W5tSHk
         B1Hsj6F9JacOellvN0OTgxD/E6WleiOQ3iyKGlogFrHx+qwp08RGZ0mj+QhpJNuAE3MC
         hIYLd2L1yNJ8b67wymi2bKPuFWD1KthvNoT4n/rbLLf8keMJKz2N1BBalkMOv/7naqqU
         BjRA6ygmeIFqgcd/AJVZqdZeaCtDD5Flsd/9+01c0FDrX+NXCZjImup6kZn41GXLPg9a
         5KW6AR/7+qY+u1zzHzNU1wkUnLPWQ1MZcuKgpDvMiKf+n7AbluhYZzWSzQ9U1OyxFYJo
         oYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520878;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cf5ZrocLuP8eawgd/E60BNCFQFk3YmpTvolIL7gKtM=;
        b=jljWnFFnDNmKz7rAcaYh58T0wLXoPGMNTfac9hNs3H06na2HuaHZ9mEoMI2du2T/gQ
         Wpt561UIre8q6HNzqSploeCxX1ZUWrqTlaYnT31E9Icurtx3yzF//Nvt41Iqeu2bQPaY
         QcyP13HvRzwSUloYZlteMbbKLrsjWnksJzTkXNIQtfGnAbPSxZU3HOy4lt5yVF+O7qUU
         ZvPMAVOYG1rt/dCOUJntiwATlhZzYEs9XO5yZ1MuclHXcMUyAzbc6e9SMOzfwGBlvSUp
         ozp7rmgVMs6tcSV22IGCkQHvFXUfnScsyTa83OvkviruHq7zlSyCsl49fhASHUL57i5E
         rYcQ==
X-Gm-Message-State: AO0yUKVJvi+qCdGiOoecUrT4FUZNpyg0ytgsuD4056GSUeA4+9KFTqDA
        MDJCaDzGVLyLBieDt6vIuZYsLSjH7wcgxnssyrIWZA==
X-Google-Smtp-Source: AK7set/y/iOOkoStxY6EOAoilZhJseSMFoch9SYTr94VAgGKeQBhx3vTLTEzlORFdORD0M0vlEHpOg==
X-Received: by 2002:a17:90b:38c5:b0:23f:81de:6a77 with SMTP id nn5-20020a17090b38c500b0023f81de6a77mr4981404pjb.28.1679520878075;
        Wed, 22 Mar 2023 14:34:38 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090ad24500b00234e6d2de3dsm10206340pjw.11.2023.03.22.14.34.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:34:37 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <06F8DFC9-26F5-475F-9428-06FED2CA01AA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_91D2A469-7A61-4CB1-93C3-4B807A11CBBD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 0/3] ext4, jbd2: journal cycled record transactions
 between each mount
Date:   Wed, 22 Mar 2023 15:34:49 -0600
In-Reply-To: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Zhang Yi <yi.zhang@huawei.com>, yukuai3@huawei.com
To:     Zhang Yi <yi.zhang@huaweicloud.com>
References: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_91D2A469-7A61-4CB1-93C3-4B807A11CBBD
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 21, 2023, at 7:33 PM, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
> This patch set add a new journal option 'JBD2_CYCLE_RECORD' and always
> enable on ext4. It saves journal head for a clean unmounted file system
> in the journal super block, which could let us record journal
> transactions between each mount continuously. It could help us to do
> journal backtrack and find root cause from a corrupted filesystem.
> Current filesystem's corruption analysis is difficult and less useful
> information, especially on the real products. It is useful to some
> extent, especially for the cases of doing fuzzy tests and deploy in some
> shout-runing products.

Another interesting side benefit of this change is that it gets a step
closer to the "lazy ext4" (log-structured optimization) that had been
described some time ago at FAST:

https://lwn.net/Articles/720226/
https://www.usenix.org/system/files/conference/fast17/fast17-aghayev.pdf
https://lists.openwall.net/linux-ext4/2017/04/11/1

Essentially, free space in the filesystem (or a large external device)
could be used as a continuous journal, and metadata would only rarely
be checkpointed to the actual filesystem.  If the "journal" is close to
wrapping to the start, either the meta/data is checkpointed (if it is
no longer actively used or can make a large write), or re-journaled to
the end of the journal.  At remount time, the full journal is read into
memory (discarding old copies of blocks) and this is used to identify
the current metadata rather than reading from the filesystem itself.

This would allow e.g. very efficient flash caching of metadata (and also
journaled data for small writes) for an HDD (or QLC) device.

Cheers, Andreas






--Apple-Mail=_91D2A469-7A61-4CB1-93C3-4B807A11CBBD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmQbdHoACgkQcqXauRfM
H+CvOxAAs8h7UWeM/XFNozgG2NrYa4eEnPHUxApEP5jcmij0B72Zg48cFi5Nivjg
DXPkslM1kDIA7Dn0a94cnwfJT6BXQrpgmhLggZtFnVVILb7+WHUuLx+1hYbILtWa
wndRZwnaV3nVWdaEL6HiZlHgmyw9fS+gWXUOSP07Me48Ox8pQVrKJ5ht0uXQszgg
ff9DaUCVmTX1OY9JvslqFh84BHCSV3/Q1fMcy8JGile1MBduRLZg2IEi+DvS+FTe
Xrwm7BSfD7MdfSSWnt5EbiZibAYNH69cCDIAHPPdDHbLVDRw/HmUcD31+OiOlriz
eme991yqCKE4BGxUl01m8WJ4uqCFEvRszAxrOFpLjtuO28xUeTkOgoqTfCwuFVDF
ifywPCKZDX9rX06t7D2DSiyupK/vFS88/7cKDraULD7vB6gXJg+sjKzSNRryKUlA
o5koFfpl8cVXAyAvARA/lIf1OyVh/jlvFcwhshMPSBh5NuP+OUvxmTdlhN44VRnH
e0enPVD+ZSZ4pDAlNYvDzo2FgQ43aCwEBxdL7H3MQ4KPwl4CZT0qwR5u9EehNJHK
BX7x/O0d8tG3dMVbfm8juQU9zSvMwgAqBEtQbGRIuKlacXs0rwUHciZyMPkohfQJ
8D5JAJ5cj/yg+WqDno1IivFvYnsxpjgSKx4JC62bEQ7w0q87qcI=
=c7GG
-----END PGP SIGNATURE-----

--Apple-Mail=_91D2A469-7A61-4CB1-93C3-4B807A11CBBD--
