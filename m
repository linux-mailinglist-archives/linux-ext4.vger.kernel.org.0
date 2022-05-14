Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65253526EA5
	for <lists+linux-ext4@lfdr.de>; Sat, 14 May 2022 09:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiENC5N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 22:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiENC4X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 22:56:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8B321D66
        for <linux-ext4@vger.kernel.org>; Fri, 13 May 2022 18:52:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24E1qBtt022837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 21:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652493132; bh=cvtH10wIW/qllaw6YhvAWlxdl4Ldk6y+ev2akrrJW/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zmg8m4qssGm0xR+cmcIwDS9Nv51Q4JMHOr/ELYenmWjcxYK5AMbd1Jdsdkf+cpnZZ
         B/uqFwv9PIyT3JwQZ8Jms5w66EOsAT33rMl0e131/ANaku25z7/MiXdAOMw9i1gmQS
         HmPt3UHAU41FJVpZW3cqtKAgdOYOboU793hKzhK09+CfWtSrzdpvnrq/rp9xW0q/hD
         fZKZ+ivm4pyifG3MFBQ1nyfoP4vNA1NoiU8RJTHGD1Wi/CVbtFDfniNihESiz8jKm2
         LF3n31SHKhkag7e/Xmw+/GkwwesJUFc6ubugWClKViGfKaSVYd0wp/pZXERS3+Hk/9
         jElxS5TaWsQ4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4B61F15C3F2A; Fri, 13 May 2022 21:52:11 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: mark group as trimmed only if it was fully scanned
Date:   Fri, 13 May 2022 21:52:10 -0400
Message-Id: <165249310227.638202.3921167990549958733.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1650214995-860245-1-git-send-email-dmtrmonakhov@yandex-team.ru>
References: <1650214995-860245-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 17 Apr 2022 20:03:15 +0300, Dmitry Monakhov wrote:
> Otherwise nonaligned fstrim calls will works inconveniently for iterative
> scanners, for example:
> 
> // trim [0,16MB] for group-1, but mark full group as trimmed
> fstrim  -o $((1024*1024*128)) -l $((1024*1024*16)) ./m
> // handle [16MB,16MB] for group-1, do nothing because group already has the flag.
> fstrim  -o $((1024*1024*144)) -l $((1024*1024*16)) ./m
> 
> [...]

Applied, thanks!

[1/1] ext4: mark group as trimmed only if it was fully scanned
      commit: 326118d762e2eaaec580fcc151f853a96f3ad71a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
