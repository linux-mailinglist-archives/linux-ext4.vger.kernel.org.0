Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75FB67C3B4
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 04:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAZDv3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 22:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZDv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 22:51:28 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E2D442D8
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 19:51:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30Q3ovVq017564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674705059; bh=ocpvNsw7+fSdBgZqyp7spGGVuyYcipqooyXy+cPrRY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cdDXtgDmJgdH+7urSjTkUNQrl9C7DjAPkGZTaw+ZBhbEgu51Sa1/hbA1QtL3IVEVE
         LT20BG8TCab+i+Xn2zbVMTmIANKLlneVAjNyvW6bQC8xr0Nib1isyMC39l5EWlWdQl
         2FxeCtoHLw04INKb6psNM5eYx9NmHYNw292TCoKMrItj0Z3S5Z6T8n4SlAycEOEPWt
         VeU5f+Dbbd+gMow0FqdZ/yfLyjKc1E24cvo9fE5jX2Va6Cf9538GnKuWh2+C0EUQvo
         oSxsDWe7adJkIAyb5fXb2pPLEn6rYCpbbXw56c508L0ppXeE1ms30r5tvUfYEJQrXy
         vBc1sHKkQ0Udw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 701C515C358A; Wed, 25 Jan 2023 22:50:57 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "lihaoxiang (F)" <lihaoxiang9@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, louhongxiang@huawei.com,
        linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
Subject: Re: [PATCH] tune2fs:check return value of ext2fs_mmp_update2 in rewrite_metadata_checksums
Date:   Wed, 25 Jan 2023 22:50:56 -0500
Message-Id: <167470504131.8995.2593568552213830201.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <fbe3716b-e8bb-58c0-6c55-a88b6979063c@huawei.com>
References: <fbe3716b-e8bb-58c0-6c55-a88b6979063c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 29 Nov 2022 14:58:12 +0800, lihaoxiang (F) wrote:
> Tune2fs hasn't consider about the result of executing ext2fs_mmp_update2
> when it try to rewrite_metadata_checksums. If the ext2fs_mmp_update2
> failed, multi-mount protection couldn't guard there has the only node
> (i.e. this program) accessing this device in the meantime.
> 
> We solve this problem to verify the return value of ext2fs_mmp_update2.
> It terminate rewrite_metadata_checksums and exit immediately if the
> wrong error code returned.
> 
> [...]

Applied, thanks!

[1/1] tune2fs:check return value of ext2fs_mmp_update2 in rewrite_metadata_checksums
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
