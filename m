Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295AF58E8A2
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiHJIYM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Aug 2022 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiHJIYL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Aug 2022 04:24:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F784EF6;
        Wed, 10 Aug 2022 01:24:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso1442247pjb.2;
        Wed, 10 Aug 2022 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=272ESQ/TJvqbzmGNO1DYDFezOW0N15ikyzzMmugZCto=;
        b=WkaQJO8c/tULKBCQUDfuoZCFVuf54swglpgYEJK+1F3jbd6T0VihyN7M/a7Ife9RQt
         B7jVJRPGbqWxzE5L/yVhV/BSmNuOBJL7ZIa2okoFhVllXC4UtaZkoQL19aoYdi4O3gP+
         7zQ3Yv0bEQRX6Ar2LtXIVW4XA7pN4Ytd54ucjxXbpjqzQzzIG2A+J2519uwDKgH0/CoS
         shqT/udJiWJGeI4AtAwer5+yqqKlYVYW/fKuKS92Mjbw3e2RIGf9qLDqfiBj3qFgknYf
         awbYZ6ZZlmr/o8ejnHRE08c6sFD6XWEdueniDElZVopSVCKYWa+CvJ4hzaigkQM4f+MA
         74lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=272ESQ/TJvqbzmGNO1DYDFezOW0N15ikyzzMmugZCto=;
        b=MWQmAjh5ZxdCa5T6riB46no+4Xct7/hQ3nGKikIuQ+ALiuQANTwZa+GAB2bGV1BBxL
         1nNG78Z+ngEsYN2q/lgS0jH8cG0Ju3qjZ7BeBpEuhkYQuzm0pZxwsZk1BrQUFEpmDyQi
         IEtnRhSs8MunKASH66BWyTj0y3eBfNB7PibaYC06NgdAb9OHMTwlQc8yphTt9T9/Mmn5
         nJvmL0W7tHXEYb5Mw/s+NOCyKc9pwZ76HcpMh7i2AkjF+EDLhLv9jXCOVu38QhsRnHNv
         YRrer1vLh+fTOaOmpA/lH3IRuDjOtLZotlUh1yL3WouUplcaI+vS41rUw+P+y4f0bqPr
         gnng==
X-Gm-Message-State: ACgBeo3/ITUmmCRNRfwYTU/p7J8q0N7X48dlzoeNt/npnPh0HB6F8BPU
        pt32BN67MwZ2ZezREK4osbw=
X-Google-Smtp-Source: AA6agR6L85XV08Ih5UkNK28Uw9lgBbUEouKsbNuBsA4K2xUuQRnf6FWyam9M19d1L8Mb6aNl0wsLdw==
X-Received: by 2002:a17:902:e752:b0:16e:f6c2:3739 with SMTP id p18-20020a170902e75200b0016ef6c23739mr26813693plf.123.1660119850447;
        Wed, 10 Aug 2022 01:24:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id g27-20020aa796bb000000b00525496442ccsm1239818pfk.216.2022.08.10.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 01:24:10 -0700 (PDT)
Message-ID: <bcc9e248-5df3-f4d2-13cb-1ea63b355978@gmail.com>
Date:   Wed, 10 Aug 2022 15:24:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5.19] Documentation: ext4: fix cell spacing of table
 heading on blockmap table
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-doc@vger.kernel.org, stable@kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809080827.108363-1-bagasdotme@gmail.com>
 <YvJ3JPFQfzbhph89@magnolia> <YvKggkBKw/jUb+SP@mit.edu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YvKggkBKw/jUb+SP@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/10/22 00:59, Theodore Ts'o wrote:
> Begas,
> 
> You sent me a patch to address this and it's fixed upstream, landing
> in Linus's tree after 5.19 release during the current merge window.
> It's cc'ed to stable@kernel.org, so it's not necessary for you to send
> it to stable@ as a separate patch.
> 
> This upstream commit is 442ec1e5bb7c ("Documentation: ext4: fix cell
> spacing of table heading on blockmap table").
> 
> 					- Ted

Hi Ted, thanks for reminding me.

As stated earlier, I was wonder why 442ec1e5bb7c is applied as 6.0 merge
window material, although the problem had been identified in 5.19 release
cycle.

-- 
An old man doll... just what I always wanted! - Clara
