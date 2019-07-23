Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E865716CF
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2019 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbfGWLR1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Jul 2019 07:17:27 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:47009 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGWLR1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Jul 2019 07:17:27 -0400
Received: by mail-oi1-f178.google.com with SMTP id 65so31980669oid.13
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2019 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sv07zRUsPtUWrK2SVPVAQfAX7dxptBNmdnmpMrj0zlk=;
        b=k9ry0LDOcVkyG0n35+8Vrr7H60O9XgLUghRybRLyJDj4TjOAQjOj+Zv/2LOi9qqTtG
         DJRq0++I8uyZjgoVy8OGCboLbgINp30aiL3R0enHNCOlPhJA+swx00+txlXjYbK/xEc3
         5dhoK8DlWNcxMZThZnd/bMqtuoENqhME1yJ6LY8NGmFusgYX26KHeK12Yxal4Cwz+OmZ
         pKwcFbeRG4fohZPJuzNfzzKyo/jI7HT0d3oKJr1T3qPC72ps7JmBFiZTMfa5WNxbnqbC
         FPWvYx2QEVWS08BlnqyiFdWyguEJ0fN01SA1I2vI0DbPC6mM1PAc/N7Ehm0eOrcbpZHx
         O6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sv07zRUsPtUWrK2SVPVAQfAX7dxptBNmdnmpMrj0zlk=;
        b=N4JpW8IVOKlvNyJPkmaKAOphIWVSNNAHm1QhhYMUjwlLUFyx8ZyuJYbOXAvoSnojuT
         TjBHoTcQ5gF/Ut64dwm+zV1/fqzNHzTpjx63olETXq3P+NqX9+Za5VuFLjRczfQVWuxj
         62KmxjGBb5vN31/goi0FvNyJwzLn4HPqIRCXDiQmkGDx/QUt8ybTHdWGU800sNUjeJey
         bjYAjwdTlqpjgKIOgL56Gj0XQkEHwxLikrsJo4zcrrv7KkIy6X2jnXhDt564zDe/HJjh
         HME5hYyq5pEFyEd0v+nwr/kVHpS16sNN7NV2wEgjkh6CJTjDL28BbQ8edS19Pav17aI4
         kQLA==
X-Gm-Message-State: APjAAAWcFmX1I2PFjJXSW2rfLMA+DfQGyEsKV0KKRms55GgUqOsrxx46
        IvP+9j5AjGGiNTe2vpDkvUz8wond
X-Google-Smtp-Source: APXvYqygaChi5AFhRLWiqztyuVLm3Zs8W1h/+jsL461oyquyTlL2H7L0Ys6B7GWz3oLHXa5D2CmDxw==
X-Received: by 2002:aca:f4ce:: with SMTP id s197mr36572350oih.45.1563880646115;
        Tue, 23 Jul 2019 04:17:26 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.20])
        by smtp.gmail.com with ESMTPSA id d22sm14548207oig.38.2019.07.23.04.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 04:17:25 -0700 (PDT)
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
Date:   Tue, 23 Jul 2019 19:17:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted & Jan,
Could you please give your valuable comments?

Thanks,
Joseph

On 19/7/19 17:22, Joseph Qi wrote:
> Hi Ted & Jan,
> I've observed an significant performance regression with the following
> commit in my Intel P3600 NVMe SSD.
> 16c54688592c ext4: Allow parallel DIO reads
> 
> From my initial investigation, it may be because of the
> inode_lock_shared (down_read) consumes more than inode_lock (down_write)
> in mixed random read write workload.
> 
> Here is my test result.
> 
> ioengine=psync
> direct=1
> rw=randrw
> iodepth=1
> numjobs=8
> size=20G
> runtime=600
> 
> w/ parallel dio reads : kernel 5.2.0
> w/o parallel dio reads: kernel 5.2.0, then revert the following commits:
>   1d39834fba99 ext4: remove EXT4_STATE_DIOREAD_LOCK flag (related)
>   e5465795cac4 ext4: fix off-by-one error when writing back pages before dio read (related)
>   16c54688592c ext4: Allow parallel DIO reads
> 
> bs=4k:
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 30898KB/s, 7724, 555.00us   | WRITE 30875KB/s, 7718, 479.70us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 117915KB/s, 29478, 248.18us | WRITE 117854KB/s，29463, 21.91us
> -------------------------------------------------------------------------------------------
> 
> bs=16k:
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 58961KB/s, 3685, 835.28us   | WRITE 58877KB/s, 3679, 1335.98us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 218409KB/s, 13650, 554.46us | WRITE 218257KB/s，13641, 29.22us
> -------------------------------------------------------------------------------------------
> 
> bs=64k:
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 119396KB/s, 1865, 1759.38us | WRITE 119159KB/s, 1861, 2532.26us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 422815KB/s, 6606, 1146.05us | WRITE 421619KB/s, 6587, 60.72us
> -------------------------------------------------------------------------------------------
> 
> bs=512k:
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 392973KB/s, 767, 5046.35us  | WRITE 393165KB/s, 767, 5359.86us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 590266KB/s, 1152, 4312.01us | WRITE 590554KB/s, 1153, 2606.82us
> -------------------------------------------------------------------------------------------
> 
> bs=1M:
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 487779KB/s, 476, 8058.55us  | WRITE 485592KB/s, 474, 8630.51us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 593927KB/s, 580, 7623.63us  | WRITE 591265KB/s, 577, 6163.42us
> -------------------------------------------------------------------------------------------
> 
> Thanks,
> Joseph
> 
