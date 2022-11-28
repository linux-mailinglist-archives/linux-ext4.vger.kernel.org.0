Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004B63A815
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 13:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiK1MVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 07:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiK1MUv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 07:20:51 -0500
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DBDF2;
        Mon, 28 Nov 2022 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669637769;
        bh=oZUcK11LcTe5OaqBGOFsh32Rl6FZE+MZoxJzj9JGOXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vbDSI6MSCBSgFNHVKgI4Ro8TuZFdYVqwHGRiGvA46RsZ0D+pJhPq3/SvIKJ7R3Jof
         nPxvCCiWnpK15+2EzkAq3eBdA7KAnUd2kQEzbidx0akgV3RBByIli1SlfMxjzo2S5P
         mqrP+nAUmv4Wi0Pn8OFRSSmBQgHPLDk4DCS0O5Zg=
Received: from rtoax.. ([111.199.188.128])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 40733690; Mon, 28 Nov 2022 20:16:07 +0800
X-QQ-mid: xmsmtpt1669637767tk6423feb
Message-ID: <tencent_2009E565C95EEAA894BD928D02202A1A180A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeTHAIwP6TwDcOOebMlxDOTqaNPBUufi8BfI7TKnvuyyF1ZkdPcr
         39+0mxGN5wD5ygA/xvCFYMqxJK9CCqDmHEPL+LsjE9Ij8Sdaw+1BDk2F7pjQ9my6eACkuBMxuK+j
         7rCWO5wKPGXW3Q8kdTNdLlkjJO9HxwOtbZJ1wE59KRWLv5X/85VFehNeckCQRvsD2xzH9lLD+Po5
         owGOedi1420nUZdeDjDYHJe9ly56h5U4F09kTWShBTsQfeIwhbBDcFxIM7vYuws9DYN1cgUIZJeh
         24NEhDfoVQVEGsUL/XAP0sJQ2NcbGtl4VR5tjYGF8RjPsW3qMuUED0Xa0SX0zBcxLfNJ7IQPl0E0
         Stho5GlBG1ExpxaplhuLVCOGBuF8aJvFZ0kGTg+T2GzUojrWNGTdvwou2jJ6psPJ4SkeD4jGV/GN
         MKMQbMJkzTyrg9rMt+ccLxsw1B2POdZHO62Zg4JnaH2wzQtRuuB0Ig0RsCq+Q9lHxHpb1iXTc6GE
         mtiB3a9B3rcBx3fF/NP6swApfo828/H4Q9gkXpStQn0gjyHhuTDmKCjEQwUDF8NBCDu72F9zu+ad
         hZ1g8bEGSoZRPCE3AMKc2gWs3tEr2PbF7A8yR+29CX5KJxvzpTpNNoP3L8nwWkPO2SGKHYPTuFi0
         bAXpcUVxK+D3QH7e1Zm54UAggILlLkmkG7vv+O4rOgRjUOXKRdCSJA4byE1cw9taSc4wpvPX2qLF
         VMdFHfvwwScpGrFJLwacQye7GWoX2IEXsMoCqt+93cylFU1FAbF7Uia+ASKQB2JXGjTTk8fEErsc
         WEgPdKGMWsoVNRw7KPuJa+vJUpBPs7FXdPJdRK6JfcRP21rM1PhjfuD6rUzjoJ8F9Gav/JBLHhFq
         V+Phs/+o8xbS1IWthQCK2mVPBRMnNiZavnexCHZ9aR0xcKlFyBg46tG6EZm2EyXj92e193ACdYvW
         UKR7bSQAe7ugtBn4vrlD1V9bpdjw6Yv5kk3aIFCI5zNKyQuZrqwX0Az1UqZFvm
From:   Rong Tao <rtoax@foxmail.com>
To:     jack@suse.cz
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, rongtao@cestc.cn, rtoax@foxmail.com
Subject: Re: Re: [PATCH] fs/ext2: Fix code indentation
Date:   Mon, 28 Nov 2022 20:16:07 +0800
X-OQ-MSGID: <20221128121607.8004-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128101759.cqrvwncfeqracaqk@quack3>
References: <20221128101759.cqrvwncfeqracaqk@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your reply, i just submit a v2.
