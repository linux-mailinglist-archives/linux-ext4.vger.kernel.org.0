Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD36662B56
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jan 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjAIQfr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 11:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjAIQfq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 11:35:46 -0500
X-Greylist: delayed 714 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 08:35:44 PST
Received: from mx02.fc.ul.pt (mx02.fc.ul.pt [IPv6:2001:690:21c0:f602::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33569B8
        for <linux-ext4@vger.kernel.org>; Mon,  9 Jan 2023 08:35:43 -0800 (PST)
Received: from FC-MBX12.fc.ul.pt (FC-MBX12.fc.ul.pt [10.121.30.27])
        by mx02.fc.ul.pt (8.14.4/8.14.4) with ESMTP id 309GNEm8048294
        for <linux-ext4@vger.kernel.org>; Mon, 9 Jan 2023 16:23:14 GMT
Received: from FC-MBX13.fc.ul.pt (10.121.30.28) by FC-MBX12.fc.ul.pt
 (10.121.30.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 9 Jan 2023
 16:23:01 +0000
Received: from FC-MBX12.fc.ul.pt (10.121.30.27) by FC-MBX13.fc.ul.pt
 (10.121.30.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 9 Jan 2023
 16:23:01 +0000
Received: from smtp.ciencias.ulisboa.pt (194.117.42.59) by FC-MBX12.fc.ul.pt
 (10.121.30.27) with Microsoft SMTP Server id 15.2.1118.7 via Frontend
 Transport; Mon, 9 Jan 2023 16:23:01 +0000
Received: from [IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd] (unknown [IPv6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: fc26887)
        by smtp.ciencias.ulisboa.pt (Postfix) with ESMTPSA id B6F8C40A096A
        for <linux-ext4@vger.kernel.org>; Mon,  9 Jan 2023 16:23:01 +0000 (WET)
Message-ID: <60d76756-772a-2ff5-3484-15db894c27d1@alunos.fc.ul.pt>
Date:   Mon, 9 Jan 2023 16:23:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Andre Coelho <fc26887@alunos.fc.ul.pt>
Subject: some ideas
To:     <linux-ext4@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-FCUL-MailScanner-Information: Please contact the ISP for more information
X-FCUL-MailScanner-ID: 309GNEm8048294
X-FCUL-MailScanner: Found to be clean
X-FCUL-MailScanner-From: fc26887@alunos.fc.ul.pt
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey.

What about a direct write (like a pointer to HD area... *hd = Stuff ), 
in ext3 ? If it is because of buffering (and that means its buffering 
because of a HD)

what about usb and tape drives ? Also since each HD is different, how do 
you know how many bytes a buffer must have...where is best to write on 
track....if there is a crash, what happened to the buffer?


i guess this analogy is correct


A man is sitting on a room, in a chair, writing a piece of 
paper....normally the writing is sequentally...why does he needs to hold 
the writing ...and then write what it thoughts ?? why not just keep 
writing?! What if he does hold the writing, will he remember what he 
thought? Where has he ended last time?! (and again , if its not a HD, 
but another device?!)


Sorry for the lame comparision, but its a free world :)


best regards

andre




-- 
André Albergaria Coelho
fc26887@alunos.fc.ul.pt

