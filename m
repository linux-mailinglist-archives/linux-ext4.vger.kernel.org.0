Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720A45ECF98
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiI0Vxs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiI0Vxq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:53:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187092F41
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:53:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrbGB032591
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315619; bh=z/dH5MAQt/MqY2/ExabwEofN5yOiVaRztYjMARf3e7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LzHWo9QPZv2Xo2LJK06saaYOg59VbSJS1rdqiXlmrcRvUVNC9XLh2dMhVUokIPO4k
         1e0CQbz0/4vCuSESzZ11OC6ci8H/rFtGeswdGF07/GBnlJJIZWcKfWiwZO8dAS7/W3
         diPrNmrjayfExb2fEVJQCyTTO/aXaOpvGbGuM5Tjc5oWxW18dQANYJv5s4jOy9V4bv
         lhozWrv545NlRUhUuQZyAqkjJl51UoGNPiNX0+5ePExLvScFlcqn99zultb4w/79h5
         PJdFwlJ4BiWoy664hyvEBxpCJIIxTRCubrFAGGtycDgS4UviAf5hPUjSeZx4XWSdkp
         91Kfm50wzCcRA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9E92715C528A; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.cz
Cc:     "Theodore Ts'o" <tytso@mit.edu>, tadeusz.struk@linaro.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid crash when inline data creation follows DIO write
Date:   Tue, 27 Sep 2022 17:53:32 -0400
Message-Id: <166431556705.3511882.4814006809885292570.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220727155753.13969-1-jack@suse.cz>
References: <20220727155753.13969-1-jack@suse.cz>
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

On Wed, 27 Jul 2022 17:57:53 +0200, Jan Kara wrote:
> When inode is created and written to using direct IO, there is nothing
> to clear the EXT4_STATE_MAY_INLINE_DATA flag. Thus when inode gets
> truncated later to say 1 byte and written using normal write, we will
> try to store the data as inline data. This confuses the code later
> because the inode now has both normal block and inline data allocated
> and the confusion manifests for example as:
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid crash when inline data creation follows DIO write
      commit: 4331037750fdd4c698facc8a03075f88f15ffbe6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
