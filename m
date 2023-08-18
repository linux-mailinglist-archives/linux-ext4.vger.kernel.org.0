Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCD78054D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbjHRFFn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357977AbjHRFFU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E33AA7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55DJp026892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335115; bh=tRuZfBTT/OFbZo1TnE6yj28esocX0W72hSQNPJ5gcqU=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=UT4yVnpawOq8JuaVLD8oNQ+jeiIMAwmUCIhLGAJUQFE9qa+7lgsmTAaFsS/u3pqRY
         zahCtp81j1qIwyJM5MXvJRmZt5QM3/O/OWnlODpTiCG1VxLS9DFlm59CAW5v1ltD/4
         Z1PbymVwqAjQtx2jrWbsnxbNxTqVSVhYOe5ubLg/EinMdFGiVoE2WWgCBLSgNDL3Iu
         bsepR2sH2WUZApch5n7YV8p8s53wciCGTapYEZAmjWst+fachI+Q4VgDU0TjG2ctGG
         J06whLhqzJdv/NLv+okgqhTOkBzNvZGFfyLIs7V8GFn1zdMKWFnc+khUadk8OLybTf
         cFID9+K4FvtUA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3622415C0505; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Hongfei <luhongfei@vivo.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, opensource.kernel@vivo.com
Subject: Re: [PATCH] fs/ext4: convert to use sbi directly
Date:   Fri, 18 Aug 2023 01:05:10 -0400
Message-Id: <169233503393.3504102.2784704586246686644.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230707115907.26637-1-luhongfei@vivo.com>
References: <20230707115907.26637-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 07 Jul 2023 19:59:07 +0800, Lu Hongfei wrote:
> EXT4_SB(sb) is redundant.
> 
> 

Applied, thanks!

[1/1] fs/ext4: convert to use sbi directly
      commit: 3dd76cab9492e37f84b5d443c9b9641488122e9e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
