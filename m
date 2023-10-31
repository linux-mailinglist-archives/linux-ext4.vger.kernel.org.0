Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F177DC4B4
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Oct 2023 04:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjJaDGI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Oct 2023 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaDGB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Oct 2023 23:06:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2A9A6
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 20:05:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-243.bstnma.fios.verizon.net [173.48.111.243])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39V35jXK007840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698721546; bh=5/YYM33QliVHJ/HnRDsCQ1+v1BRnOEgadsz5okdk4ao=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=eIUntb/HyBLQRvOCwLH0/Q1tTzpHDQfz5KSzulKLlIpErdY4Gap1rQoRL5Upaeqxi
         pP3EkPed79NJN0VGFr9jduHwa16VyQI4E4dDPhjwHThanYiUsDDYsGs5I9fwgxFUIC
         xZUqPBAn34LOm5TW/ubG8ImmgbroHTHsLGdzWAjEms1YL42+FBBOVv5esvJZtV/DBA
         B/NMZAQDJmryQb1V7RuMe3DXbojwFUbY2avTvpSe4gY1SAvKhvKuXxBYJQBSoptyNR
         3xiGHWGrisvrnXgrpcp7teU6eBI5XGYfoA6YBnmsWUqcwxPIgH+VlgLruU1SKnmNPv
         NEjtKcpYAPa4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 188DC15C024D; Mon, 30 Oct 2023 23:05:45 -0400 (EDT)
Date:   Mon, 30 Oct 2023 23:05:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?xJDhu5cgVsSDbiBOZ+G7jWMgKFZGLUtIVFZQTUREVC1UVFRLTEtERFQp?= 
        <v.ngocdv4@vinfast.vn>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: File system hung on kernel 4.14
Message-ID: <20231031030545.GB9741@mit.edu>
References: <fee3ba3c4b9205afc1b60aa981193fb28deab7f3.camel@vinfast.vn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fee3ba3c4b9205afc1b60aa981193fb28deab7f3.camel@vinfast.vn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 30, 2023 at 07:37:09AM +0000, Đỗ Văn Ngọc (VF-KHTVPMDDT-TTTKLKDDT) wrote:
> Dear Linux kernel ext4, Dear Ted,
> 
> We are developing project on Android 9 which used kernel 4.14.133
> version.
> And while normal using device, we have a issue device freezing and
> reboot after few minute.
> I checked the log and saw kernel hung on filesystem as below:

I've already replied to your first e-mail sent directly to me.  It
appears to be a hardware problem, or possibly a device driver issue.
But it's not a file system issue.  Basically, ext4 submitted an I/O,
and then calls io_schedule(), and I/O never completes....

    	       		      	      	    - Ted

[15159.874154] Call trace: 
[15159.874157] [<000000005e1d80e5>] __switch_to+0x94/0xd8 
[15159.874161] [<00000000a85c7184>] __schedule+0x274/0x940 
[15159.874163] [<00000000c9c2c8f0>] schedule+0x40/0xa8 
[15159.874167] [<00000000a97520e1>] io_schedule+0x20/0x40 
[15159.874175] [<000000008d5c36d0>] blk_mq_get_tag+0x194/0x340 
[15159.874178] [<00000000f97393cb>] blk_mq_get_request+0x164/0x3b0 
[15159.874181] [<00000000e69c8e58>] blk_mq_make_request+0xc8/0x6f8 
[15159.874187] [<00000000e88e7453>] generic_make_request+0xf4/0x288 
[15159.874190] [<0000000016cf2add>] submit_bio+0x5c/0x1d0 
[15159.874196] [<0000000097be4708>] ext4_io_submit+0x54/0x68 
[15159.874199] [<00000000e9c80f00>] ext4_bio_write_page+0x1b0/0x528 
[15159.874202] [<000000009bf94bad>] mpage_submit_page+0x60/0x90 
[15159.874205] [<00000000da1a9585>] mpage_map_and_submit_buffers+0x138/0x238 
[15159.874208] [<00000000c84c3e14>] ext4_writepages+0x8dc/0xe08 
[15159.874214] [<000000007a345b10>] do_writepages+0x5c/0x108 
[15159.874217] [<00000000ef1a522d>] __writeback_single_inode+0x48/0x4f8 
[15159.874220] [<00000000aeac1ba5>] writeback_sb_inodes+0x1c0/0x470 
[15159.874223] [<00000000f7f818b4>] __writeback_inodes_wb+0x78/0xc8 
[15159.874225] [<00000000ae30bb56>] wb_writeback+0x24c/0x3d8 
[15159.874228] [<00000000b489a91f>] wb_workfn+0x1c4/0x490 
[15159.874233] [<000000004df896a9>] process_one_work+0x1d8/0x498 
[15159.874236] [<00000000d7fa6dd7>] worker_thread+0x4c/0x478 
[15159.874240] [<00000000f46ec2f2>] kthread+0x138/0x140 
[15159.874243] [<000000009e914ea4>] ret_from_fork+0x10/0x1c
