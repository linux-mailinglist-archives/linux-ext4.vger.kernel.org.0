Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFC770F92
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Aug 2023 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHEMUq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Aug 2023 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHEMUp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Aug 2023 08:20:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB544BD
        for <linux-ext4@vger.kernel.org>; Sat,  5 Aug 2023 05:20:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 375CKVrX027553
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Aug 2023 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691238033; bh=eYb2O0IuXmf6IAFBpyM9vHqkTVB4ZgGCAGWOPW1z0h0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ZY2yisKMU0yHb1/kCsKiDCDsQsEn660in3xvdlb2WQk3zPH76vea1fx51ChilGeQL
         rTTOCLXGq6aSfrjIS7XwhePnbC3IwWovsS/ILiFSAsk85/U3tcI88fzk+IMIPI+j6B
         74u3/fEBO2iDNCzSKH5m6BOm+zGidr8br7FO8noipuOHLTJck5AE8JwVyyw11PC9cN
         EFcgem/DqZfeb0a7P8NceygvA7Yh3jJYDofhSZZ8PK2EhMYwBSiaBc/hZdGaq5Uhp9
         5kkix/Woi/tkIPt8s6PFG14pluz5bB71glHJT92XOgCoOEl1D8X2lUz9rvH0PJiPDb
         QRSXS+QbgUTAw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 525B815C04F1; Sat,  5 Aug 2023 08:20:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}
Date:   Sat,  5 Aug 2023 08:20:24 -0400
Message-Id: <169123801881.1434487.6868481309254151521.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803091713.13239-1-lhenriques@suse.de>
References: <20230803091713.13239-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 03 Aug 2023 10:17:13 +0100, Luís Henriques wrote:
> If the filename casefolding fails, we'll be leaking memory from the
> fscrypt_name struct, namely from the 'crypto_buf.name' member.
> 
> Make sure we free it in the error path on both ext4_fname_setup_filename()
> and ext4_fname_prepare_lookup() functions.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}
      commit: 7ca4b085f430f3774c3838b3da569ceccd6a0177

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
