Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1E16B7B4
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 03:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgBYCYn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 21:24:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgBYCYm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 21:24:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so6360114pfb.7
        for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2020 18:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YbgGKrqNaKXp2P1o2CFhhdjDJfnvbygLowAWzXITc0o=;
        b=pQ9W2Hnv2ST8c3qN2fi+GCnKQg8phWjO/yITBWU7lVXRtGSK0BxYYEyYmDrDzJKMzB
         4SQoSw2iaQdUd0HADngXJvdAKYvMRCudTDn8Km1ZcAiAoDsbkbz8g7lnAn9U5rb72Jbc
         ummSJI5Tl7A/Jb9u5+8MGt9ZDnYzzEax0jykd3Ra3mg0GqzwuBIUSX5uYAkDuRE2JSuk
         CglJXHJVIEKTpIzWM6Ibv5D3UTFntIWb0EoP5RfAS62IdrkluUZ68pExflwkQ+M8UOCt
         b/CZwWj/vWfMRW+bejcwh9tYM9IjyAlCHRX3zvVlJYt6e9T8UebumbSFCXnC7+fcVeU5
         d6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbgGKrqNaKXp2P1o2CFhhdjDJfnvbygLowAWzXITc0o=;
        b=aRwxiu8XOLrh/Bw7bJuy4FZa1pZP7umHFklnL41djRA+WyZD9iIKnwpSCUHaOEOQxk
         Awes/eCMxY2gajdr+Xu1OZdu0ZyfnBwTwTFYx4kOiSRiJHmCuo1CSVciNAhXqn5qIL7p
         eDJL/AOxlSvI23R627Ci1Pk8M5fZ3tUQepeHftT5FuhUojLudwN4AYKGcsCqunJ9V264
         ym85EI4lJ5mruIodnVJ6uMMG14CSge9wQnsRbh0cRKD0N4apRUfppEfLuZT0tADq+b/a
         2ux+iBK6NjYb0SPYaIKI1Zrs4C/gOmrdKrIcDU8yjmsyta8+yB8/Yhbg4k+UOi6ig5ZK
         Hd1g==
X-Gm-Message-State: APjAAAWcKhX3t2TfxGl10ZRsUWAlHeEu9kfZLiQPStaRXaDHk37HzMhF
        hD4aaPqV7Z0jV+EyGO9dmmAqhg==
X-Google-Smtp-Source: APXvYqxjwFg+b82hQJR4vQpUyb6M+nTgv+CVa2mYd/vuiLte+VdequLaoFu6XweGKMnyUWMYsXHVkw==
X-Received: by 2002:a05:6a00:45:: with SMTP id i5mr53824302pfk.252.1582597480784;
        Mon, 24 Feb 2020 18:24:40 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c188sm14713490pfb.151.2020.02.24.18.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 18:24:40 -0800 (PST)
Subject: Re: [PATCH v3] io_uring: fix poll_list race for
 SETUP_IOPOLL|SETUP_SQPOLL
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        io-uring@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20200224070354.3774-1-xiaoguang.wang@linux.alibaba.com>
 <6ee28cc6-3c4c-a5cb-75d4-83bccf93fb2a@kernel.dk>
 <ca4803dc-af0c-5d6e-834a-343e3100f6f3@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce98c243-091a-49a6-0047-c482624989a5@kernel.dk>
Date:   Mon, 24 Feb 2020 19:24:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca4803dc-af0c-5d6e-834a-343e3100f6f3@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/24/20 7:00 PM, Xiaoguang Wang wrote:
> Thanks for your modified version, it works well and looks much better,
> after applying this version, I also don't see this hang issue again.
> From your codes, now I understand why we don't need to hold
> uring_lock, thanks.  Should I send this v4 version with your codes?

Yeah, please send a v4, that'd be great. Thanks!

-- 
Jens Axboe

