Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4E6D048F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjC3MWg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjC3MWd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 08:22:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50A76A5
        for <linux-ext4@vger.kernel.org>; Thu, 30 Mar 2023 05:22:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so75881026eda.0
        for <linux-ext4@vger.kernel.org>; Thu, 30 Mar 2023 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680178918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4bHiM5AKFbTF2u5UAB+TNrT66XPEzCil5oeY4hovDk=;
        b=T60J74KHte5gR4A2ObCdlhvKx04vu1LxaBVuGnbLJorGnfxs6abmfZ4ipUzuf6kEJF
         4il/j0a2lU1F+m0QhBy+WfOb4A2g5IoTtdMg7gy033HoFTvmwQ8ruMP+vQ0AMbwC9PMB
         5JmL7la2idSQ0SuSrRGXT3XE20gJY/AU15dOXF8IlYSdDlNaMWI0yb2Y9IHMj+dtp+rz
         vmeUtSmdoPdwzQ63na6FEMlNSzatuPFsCeaS/v4GRzzxXOTESfx7ujIFyG1pgQDaSJA6
         R8xMGbavjQsFuIUlVtZ4uQ1pIlbXiWySncOxfEGgmC/VcM8aFXPIiv1/3R15Xc2j9Vuz
         nFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4bHiM5AKFbTF2u5UAB+TNrT66XPEzCil5oeY4hovDk=;
        b=2S1i2WozZJ1uSV0ouqAu5jHsDfBhiAZesI1Yu47OOUgDfc8WvnqZSKeeuGnvRicC7O
         hAQCR5i5H5F8MukWHfqB6UKEhnvvnfR4bjgE7GNG0k0qTQ8aF04zxYZ0DWi8/hd3XNun
         GZ5y6qlkC9sJUNl3RV6p8ibPsi+0nCoe4F+d+NlTQsq0E5D0Ba7d25QdyYWYfRUdwDFx
         BjGBA4Yq+NHU8t3XVcw32gpO7IqUdYwYRN9UMESxBzceVBE1zjEe3py0iXX5/B4AhV2p
         q2oJjnCS1gRi/A+W6Y/UqjhPNPb/cZ0RC4QlSsbSNk8dhfJfoAiqra2rPstvRTWQ4YyV
         Xe0g==
X-Gm-Message-State: AAQBX9cBlGzFYAjJ/mnYp62utj2wHssV+meT1PzVUuDOAktWXxWQBhIh
        EWaG7l/xR31zDH7hFKEaAMgIXw==
X-Google-Smtp-Source: AKy350bTD9Cma6jj52phoECl8YQwfIuls2oY1yimLQtOqLRT6haZq4PD+GgsCcNE4ury9LYhN14TEA==
X-Received: by 2002:a17:906:9f19:b0:93c:847d:a456 with SMTP id fy25-20020a1709069f1900b0093c847da456mr26716072ejc.22.1680178918505;
        Thu, 30 Mar 2023 05:21:58 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906694200b0092b546b57casm17629546ejs.195.2023.03.30.05.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 05:21:57 -0700 (PDT)
Message-ID: <661ff1fb-ab0d-e0a3-693c-073443f556df@linaro.org>
Date:   Thu, 30 Mar 2023 13:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RESEND][for-stable 5.10, 5.4, 4.19, 4.14] ext4: fix kernel
 BUG in 'ext4_write_inline_data_end()'
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@kernel.org, stable@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, boyu.mt@taobao.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com,
        Jun Nie <jun.nie@linaro.org>
References: <20230307103840.2603092-1-tudor.ambarus@linaro.org>
 <42739df1-8b63-dfd6-6ec5-6c59d5d41dd8@linaro.org>
 <ZCV6I-CBHVw2GPre@kroah.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZCV6I-CBHVw2GPre@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/30/23 13:01, Greg KH wrote:
> On Thu, Mar 30, 2023 at 12:42:27PM +0100, Tudor Ambarus wrote:
>> + stable@vger.kernel.org
>>
>> Hi!
>>
>> Can we queue this to Linux stable, please?
> 
> Queue what exactly?
> 

The patch on which we reply:
https://lore.kernel.org/all/20230307103840.2603092-1-tudor.ambarus@linaro.org/

Shall I do something different next time?

ta
