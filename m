Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029947A21F2
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Sep 2023 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjIOPIq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Sep 2023 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjIOPIo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Sep 2023 11:08:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F61E50
        for <linux-ext4@vger.kernel.org>; Fri, 15 Sep 2023 08:07:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38FF6LsK005863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694790384; bh=qiyMpOmp/KYyKki9JvjDI4nDTPzBSQhw+7e6fLOvqjE=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=H2BshBfwZcaLur7HefT4xBBSCct2fC36Ug6s56CEJh5ohaSQzylpRGUjupkJ5NT9C
         c5ofhzUU5hk+mdvvA7bec2ExVxw7Tf+N1uKKxc+1w/PTeAt8SB3z7Cf7wbNBOeOkgX
         EKuSPPb3pTrMHBK/sTitAANSQdOOn09pJYSGsEeHD8Ipz6ylsYXtta1pL7nu8dnKiA
         hPNFd5GpgZ0HMMWVqoDDU7YpM0LDUnLuY6DAxWFdptjI+teKxVsjpqURXoB65vr7Tv
         UYYdJvUayXUw6RorJC7DXJqcu2HvBwiGIchkqWhMNxOd2f/jgSz6J9V/pSbrP6L55L
         tn9O7XyHTl9lQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0415B15C0266; Fri, 15 Sep 2023 11:06:21 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, yi.zhang@huawei.com, djwong@kernel.org,
        zhangshida <starzhangzsd@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v4] ext4: Fix rec_len verify error
Date:   Fri, 15 Sep 2023 11:06:19 -0400
Message-Id: <169479037020.1500633.4914927617396834377.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803060938.1929759-1-zhangshida@kylinos.cn>
References: <20230803060938.1929759-1-zhangshida@kylinos.cn>
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


On Thu, 03 Aug 2023 14:09:38 +0800, zhangshida wrote:
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
> 
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix rec_len verify error
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
