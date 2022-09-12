Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47B5B59B3
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiILLzj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiILLzi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 07:55:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791024BDD
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 04:55:37 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28CBtIBo031213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 07:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662983720; bh=NDs8KLQZaV5wUG7roVC8z1/M8hrq6vyq+n80fEuy6Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=grz9sIJWa62zL5EYTy6SonMTUmJJVa2lpranmh0rpiZjhbGmVpUAJ6PVjvj1LAGu0
         cRPXAH+Gqg4KStjKVkVcCWlEkDwcruq7E2e9sNBNtbUwmG83bq07iuYyE4hnV26k+R
         M4dbiVu5pv2zpHpamPrOkRd9dCfqMBdYa02fdOAp4su/oGW9Mg5REoDFk5wpdpA0z5
         lltL15nzo4XXY+QB7Jk5DDUD3Uc95OjNIG5WhoU8LbqmqU555MhomOfiUTvlR71NCI
         DQ47OX6qszTVZBklhEFBvjfOTcqsZRbjwyzoC1/ljktb0rKO2sog0ede4p5iqWu637
         VQ9Gw/N1elRhA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A58F515C526D; Mon, 12 Sep 2022 07:55:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, wuguanghao3@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] tune2fs: tune2fs_main() should return rc when some error, occurs
Date:   Mon, 12 Sep 2022 07:55:15 -0400
Message-Id: <166298370796.2551439.3699391083170476441.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <7a6e1a43-d041-c3cf-a3dd-a9761d8dd4d6@huawei.com>
References: <7a6e1a43-d041-c3cf-a3dd-a9761d8dd4d6@huawei.com>
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

On Mon, 5 Sep 2022 23:40:01 +0800, Zhiqiang Liu wrote:
> If some error occurs, tune2fs_main() will go to closefs tag for
> releasing resource, and it should return correct value (rc) instead
> of 0 when ext2fs_close_free(&fs) successes.
> 
> 

Applied, thanks!

[1/1] tune2fs: tune2fs_main() should return rc when some error, occurs
      commit: 77ac16dfba42e0d152b1e99359e01a933f8cc6f9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
