Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F876D079
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjHBOsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjHBOr4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 10:47:56 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF541196
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690987667;
        bh=Ss4Iy5c0OLQoEak5uR2baz/xajhe+veguTh5u79Ka+I=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=WKK2kOENiZ4Ba6ANStWPagaJE66JAtSu8uQDev6+x+HGAFGolTxfMb3z8t0D0hxwm
         2+RLKsnYK4aHkYovNyqKbiDSHv/kA5fcyEvS2+Vz3yqfYPUXLOdqXktBNlAZUMYd9u
         J1u3qAX8twSjGI74osxTxLi0RM72VwCkOc90ayOo=
Received: from [IPV6:2409:8a00:2577:9740:9ca5:5f74:38db:4c67] ([2409:8a00:2577:9740:9ca5:5f74:38db:4c67])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id BA718839; Wed, 02 Aug 2023 22:46:39 +0800
X-QQ-mid: xmsmtpt1690987599tr9zv5in7
Message-ID: <tencent_F4B9140D4D9156ACC409A0E76FEF17647405@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmF0QrROo5Y6+fLrdA1wjUKWrQ4eRtDY3HMwugxnzQDR/GH71AS5k
         IUPo3qNveVKv2A5OV7NhadYBeNKKPNSriOlzg+BQdu6LyOHimVmFSfGJqNUu56nqZagtm8Z3TbUc
         DDiVlYDuxn7riLckRInrKmAS4w1tvWsESIvtyQ1/0U4godgKJBoOn4ALJXgne3HRn/LLiN1nh87A
         IPXiX3saVzdHFrV6XrhpsuQGxOY8oHKyLTwntQ/eWdRB+C7FnLgC3vgm/4Mug4YHMOj7TJQRStvA
         QF9FNd943g3r4HwlrJsJM/vwrydT2G80TiVmeFc22ptP3YO7nwX52DNXj7m3XVMgTrdOzzJDtDUJ
         aENdszFuhYCntwRV9MMn9dZyvt7AM42rt4wMiRBxpv1aFNm4bB66hWp7hgOgj7k05moFACIKhl0e
         cbSwv5WksIH0Asf1LlZSbRXZ377Pcv8m8PT0vOgexCTbvlzNvabBoj97A1vKYJMtwA35D4MnVGI6
         q9PSnuJxRWGdjYJtEhnJ3UIvhDGp0JiaxG0F3YzHT4Z8nLwcsiExk2rNB2B7MA9YTu8WD1KVLIQg
         ADZy0k5Fl6GIQYeMgp7DOk4HjnuPj4DRg5TnLuEoZ7CmSoFqxe47KM8XZpAn0sUh/UHWYR/eIytS
         XHZRj/PtTC6WMit7iuZ7XgqEne+fV3HAbk3fVHlDFeUJSFepKTa3BDyXTZbU/WgGNbTJjbjDAHou
         3x/gUZ7/jfpjEd22/3s1MaVxnGFD7NVut3n7EQ8fyjLU8Ds9Qg5Oy1nXpVR8sHhaUsipyu1WlvlO
         heidAlT5uO68BlIjV6I1WXju54zhgCYZCqq28Yxwoe7KzrYg0LoGlTKWatLbuWjXGx7aA+JyppHU
         AB7lz7HTh8Pkk//kkpHEkZsBvstr74ln0XQKCQ/WGVyA5/GlkZPfQDTvipTKM0T6dS9uTrJIsQmH
         zXWnPqm1UPAbkgteu0ZOoU3WOnZGRhYadcwbISwKX8Itb18111OWAsdWEZHgj2
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <09ed2f85-2d53-ff7b-5fb3-8f976b6d5f39@foxmail.com>
Date:   Wed, 2 Aug 2023 22:46:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] jbd2: Remove unused t_handle_lock
Content-Language: en-US
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org
References: <87y1iwwi83.fsf@doe.com>
From:   Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <87y1iwwi83.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks. Fixed.

On 7/31/23 17:19, Ritesh Harjani (IBM) wrote:
> Reviewed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>

