Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A3281CA3
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBUKJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJBUKG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 16:10:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9C1C0613D0
        for <linux-ext4@vger.kernel.org>; Fri,  2 Oct 2020 13:10:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so2887688ioo.1
        for <linux-ext4@vger.kernel.org>; Fri, 02 Oct 2020 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v2Dl3wLUDZsk2cy7EPTfWC6YEf4bhLZvFJn6hWx46xI=;
        b=MOCvpZFf6c8wgEfyMWDGK3T2T/CFYAw+EitQWl97GAhDK6+PX6of9/4mNGnYTtb0gW
         OBiYXRrdNRtrAoQVyBt1F3sC4cPVx/ZqKoDedQ1yfKUerrRCu3J2J/i7DL94BPm4HT3x
         DjJz5caP6/PKLlXcOTNnObZfuGaOBzYkCBtGApO98E5ObghacXbmAJ9dMJW8O8dLrVdR
         gE53FpaBNYLH7nC4Of1JKD5rR003snOZm/n3Hcxx3bPGz39EhEp4OQ4LlSTNzY1L5gKs
         jHnnDAtPj+kdwuVg/NiEqZUi+tcOmmVnRaNAQPpt7hZ/DtbwVJB7CU/AJb5rhw4hBqC8
         jySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2Dl3wLUDZsk2cy7EPTfWC6YEf4bhLZvFJn6hWx46xI=;
        b=GV2SsgwN4CDRxClRWsMeNr8CNlWCmBE12jTPOvSXundm8FivqZtxwkW5pygw3kbr92
         aSr+L+MGOKC446Cm25GVZfx0iVsWXetO6XlJfRsLYz4PaqbLAxr1Fgcm4utM95P5xlk3
         2bj6nqtEBUvEiSwmd/46ZrnYJph4FiiiiLHzqricVo7QXlO84XysNLHlKAyQ2sHkiFFF
         rjv7xkTUmk9EEAp5D15ZHsY3nFG2GEis5bPNqWb7EO5ahAwCN24EhArLxhNnAkY42hAv
         gM0kVUr4tFVJsAuWp9uvTeyHuM/Ei5BTQp/KPj0SS0bZ6pZ58zfKKUszBM/6CdSaSqgm
         buog==
X-Gm-Message-State: AOAM531l7+sGURlTteBXeUrIFqJSOXzQiLwb+qGrMkouEsbSu89uLkGd
        f91ja1109Nl3+9MKgO+qy8P52w==
X-Google-Smtp-Source: ABdhPJxrxoxKId+X9HAW2tq4mZlRsdrQONTZFu0ou6YbHg6MRIlxnxAxOTEC/Kq90v4buUQL55cA6g==
X-Received: by 2002:a05:6602:2e89:: with SMTP id m9mr3210239iow.77.1601669403789;
        Fri, 02 Oct 2020 13:10:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m204sm1147973ioa.20.2020.10.02.13.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:10:03 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20201002200844.GW23474@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d815eb12-5b29-61b1-b10a-76af34095643@kernel.dk>
Date:   Fri, 2 Oct 2020 14:10:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002200844.GW23474@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/2/20 2:08 PM, Theodore Y. Ts'o wrote:
> On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
>> ext4 uses generic_file_read_iter(), which already supports this.
>>
>> Cc: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Applied, thanks.   (And apologies for the delay.)

Well, the topic took a bit of a detour! Thanks Ted.

-- 
Jens Axboe

