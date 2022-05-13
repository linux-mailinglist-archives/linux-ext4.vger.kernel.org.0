Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA20526C26
	for <lists+linux-ext4@lfdr.de>; Fri, 13 May 2022 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384622AbiEMVP0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 17:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEMVPZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 17:15:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADB5F73;
        Fri, 13 May 2022 14:15:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24DLFH7E028110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652476520; bh=/cTWRJMCiKtMCEg/Ssy1mTCj87mtlg66goQED0Wcx2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kciOY6Ci3jCpaPVhTe1nJnZJpj48/mifroAMhhP15OgwqYQKUec7hWY6ZkzK9CkGj
         eJlu+KiJTRh05eZaASBkqhvcgTueZiDgAyDPCxBLTFyJ9GFUBgSCl97s53Glt/5FEL
         xJjbxBIJTUyMK5vnuSVg81R6cAuYoyFAc1/qFrT+Vuo3sng6rpoHZX5+G/xDNca+B1
         f8MfhX60rMAxf2t6x8JZ4MizjOqhQcO5LPAZN7gcPRUgKMcI1tEssLTV4kEmilQ6Dy
         XHfSw5mvzF27QA4OREKBt+eje6j1ZMNhiKGm9U10nX92hYrisYRtWcIQrsP80zYWF4
         F4p5dUcIUtAUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 64B9415C3F2A; Fri, 13 May 2022 17:15:17 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-ext4@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] ext4: remove unnecessary conditional
Date:   Fri, 13 May 2022 17:15:15 -0400
Message-Id: <165247650913.591780.3906460876756807177.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220411032337.2517465-1-lv.ruyi@zte.com.cn>
References: <20220411032337.2517465-1-lv.ruyi@zte.com.cn>
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

On Mon, 11 Apr 2022 03:23:37 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> iput() has already handled null and non-null parameter, so it is no
> need to use if().
> 
> 

Applied, thanks!

[1/1] ext4: remove unnecessary conditional
      commit: 784a09951c1d8383498c0df091a37db612bebfc7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
