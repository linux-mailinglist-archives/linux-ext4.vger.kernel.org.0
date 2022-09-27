Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801105ECF95
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiI0Vxp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiI0Vxo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:53:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0992F41
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:53:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrb2a032585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315618; bh=VgHYE0p98xfHsiire9xYV+Ua1T/r29z8AWyh89pCmr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lnvyNqdqA6rtSKkUtMk2ehVnIeYjQ8lvtcyhL96fzNTe6LaSG0LM94jQ+bYTBusJZ
         TAzazvHgrFccCs/vOS0sGDlhwYhNddAxoi6sQXEWqZv5TT9jwP1Sy20J+hRixQscyN
         ABRuURokY/gOqHz5xDisJ37iEEqnSt8NPInZE3kd+NCCvfHqtPEm/gXRFHrgUNz7hT
         lnAFHgBAFYDfvzaKj5p7iNBdyAJrp/rsqeSbnyElW+R0Lrvv4688DSVBdiU48KyIQ8
         s1jt3OxLdcxRlIjCdndNZpjT+sYRhplcmALIOlXJOKwsQ+p6e6gvKAQpdRFjcFZKWJ
         hv/M/lgSCHdfQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9CB3815C5289; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, enwlinux@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] ext4: minor defrag code improvements
Date:   Tue, 27 Sep 2022 17:53:31 -0400
Message-Id: <166431556704.3511882.6483763123662055219.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220722163910.268564-1-enwlinux@gmail.com>
References: <20220722163910.268564-1-enwlinux@gmail.com>
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

On Fri, 22 Jul 2022 12:39:10 -0400, Eric Whitney wrote:
> Modify the error returns for two file types that can't be defragged to
> more clearly communicate those restrictions to a caller.  When the
> defrag code is applied to swap files, return -ETXTBSY, and when applied
> to quota files, return -EOPNOTSUPP.  Move an extent tree search whose
> results are only occasionally required to the site always requiring them
> for improved efficiency.  Address a few typos.
> 
> [...]

Applied, thanks!

[1/1] ext4: minor defrag code improvements
      commit: d412df530f77d0f61c41b83f925997452fc3944c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
