Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389C770F91
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Aug 2023 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHEMUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Aug 2023 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHEMUl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Aug 2023 08:20:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4344BD
        for <linux-ext4@vger.kernel.org>; Sat,  5 Aug 2023 05:20:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 375CKV6G027552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Aug 2023 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691238033; bh=qXWo8bRB000n09JYfiyGu7wd9tcBPraNFUadnucQZYU=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Yjg6FmFGaTs7FsE+tv0fVpBYtfrkrzE1zSUKsYD0vZPa9bCzS3xD5VTkH1jZBsUPf
         IN858uu2nFG2X18eSLOYKXSkF/UUWPbpP73+pEWSca4v3UAaBpsJ5v1Dbd5WoeRfwZ
         Ds+4+x/33xartZx0NG/RjysZ2fqqRdfXsrvIGUZ+bzxOwuw4HKQA4FCKg94l7Qs4dY
         G7Fl//7XQjCtw58jXvZhaOn6zK9rjYIn4AXuZ0DBMAOk8+gS126PrEmnRhxLK9aKg7
         9+ljzPn6hpuvW+xFeCn2YA2I9gBiTeu4uSkhw/J9sU3MV5dQpJdSEXRSNS7ZEblQ4X
         q1Qi2TiUHZJog==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5734B15C04F4; Sat,  5 Aug 2023 08:20:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] jbd2: Remove unused t_handle_lock
Date:   Sat,  5 Aug 2023 08:20:27 -0400
Message-Id: <169123801882.1434487.9999343344380619425.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <tencent_8477CBE568348A1862C64E393D587B342008@qq.com>
References: <tencent_8477CBE568348A1862C64E393D587B342008@qq.com>
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


On Wed, 02 Aug 2023 22:45:34 +0800, Wang Jianjian wrote:
> Since commit f7f497cb7024 ("jbd2: kill t_handle_lock
> transaction spinlock"), this lock has been no use.
> 
> 

Applied, thanks!

[1/1] jbd2: Remove unused t_handle_lock
      commit: e15e117bbbe18258a5ad506bbf6c58ff129c9576

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
