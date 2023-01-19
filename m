Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5A673D79
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjASP1Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 10:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjASP1W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 10:27:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B081014
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 07:27:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30JFRB80011457
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 10:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674142032; bh=FiJMiY5I4sgQW1qw/ruY1RwYObvxRubNSKnUIQ1u+WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eF0KC7+C8SRhNH37rjXCEUXW2Tei2+2Dex5urYe8xm6WAaplXx13WNvFpH16LEbZn
         PrrD1FRDymqmc2xAgFGi/FZ5J/1FDGylHcFNTnbaIWXGDcw3Rk6+mT/biA5pEIIZMB
         /aO+ASIVQMcDgoAszCmB8GSyDN9vdXOLzMg7gMXqYnScg6SwNaW8iDQM0FzMCPMqW6
         JEH4+oBdjo0d3j5sm9sk/myUfRvei4Xar8jywmelt7tyxZBUppflAoGY2o68pazeeR
         Ww4DtaDUIIWVI43OYEdFCGtFL6NC8KUSbBTo3I7yWyE2QEUO3PIW+7wcgP/zDD6wFm
         OinxB2h1aF/pQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0C24415C46A1; Thu, 19 Jan 2023 10:27:11 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: print error message when closing the fs fails
Date:   Thu, 19 Jan 2023 10:27:06 -0500
Message-Id: <167414201625.2737146.8413750757027853269.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220923132817.1701711-1-lkundrak@v3.sk>
References: <20220923132817.1701711-1-lkundrak@v3.sk>
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

On Fri, 23 Sep 2022 15:28:17 +0200, Lubomir Rintel wrote:
> I encountered an I/O error on writing the superblock on a drive:
> 
>   ...
>   pwrite64(3, ..., 114688, 97844727808) = 114688
>   fsync(3) = -1 EIO (Input/output error)
>   close(3) = 0
>   ...
> 
> [...]

Applied, thanks!

[1/1] tune2fs: print error message when closing the fs fails
      commit: 7c4bbd8f052af2b2be84293ddeff0d36e35b5a8f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
