Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50F57E2BB
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiGVN7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiGVN66 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4F972F1;
        Fri, 22 Jul 2022 06:58:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwUMk016784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=T15V89XX7qWqTYfArHI6um6VHFVudrMvVTFC24tW46I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ASzXJv3QKSOMKeFgYu89kmFN9Nwl+FMvpmH0TAQkAY1L7a+oKeXnPZrZLxnS8yUQn
         2sqPw1xt/KtoEG3WNOH5ryvV6Gc8lc5AZyIzZ4buaBCr1wO+NzMxPov45IoMvEMlVv
         jfWiGcrj2dzaqz8tQ29F3Nf1ePUd0PaxGCfj6IjoWPn6+5ZnWaf8IhCpLcRj6ZQZ+w
         j2ejNSJhBysOvKeaJKszeOu7HTIVoqx1kRFdiD1l9D+G25wMCJA7ybVJLWt4u+uyjb
         txF51jf2VsdYfMtgg4T1shTyzLjwwm/L6h1GA2KgI1L8aqx6CcCtR5vIRW8DQF1yoE
         Fq6hLchzvqWhg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7BB1C15C3F0B; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: avoid remove directory when directory is corrupted
Date:   Fri, 22 Jul 2022 09:58:23 -0400
Message-Id: <165849767594.303416.6891115101184115416.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220622090223.682234-1-yebin10@huawei.com>
References: <20220622090223.682234-1-yebin10@huawei.com>
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

On Wed, 22 Jun 2022 17:02:23 +0800, Ye Bin wrote:
> Now if check directoy entry is corrupted, ext4_empty_dir may return true
> then directory will be removed when file system mounted with "errors=continue".
> In order not to make things worse just return false when directory is corrupted.
> 
> 

Applied, thanks!

[1/1] ext4: avoid remove directory when directory is corrupted
      commit: 39aa54792eaef404150d323709252f048aa5b6ff

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
