Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034C3DB9E3
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503690AbfJQWt4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Oct 2019 18:49:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41614 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438306AbfJQWt4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Oct 2019 18:49:56 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so5105180ioj.8
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2019 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MyHKI7xgzTt0YUZSaYHwYGf4C0qmP6isFfQy6CXF8eE=;
        b=GqbADiPu2mApWKaNOdnEUmPgfGIl0jR3Oxp03Ktbq9lZE+wkWc2nm/i6Q/GPscjYOr
         XirENEZLkYjcB4zcnH1OzrSzaReXbNRmti0SLQpi56XB9u8Gi4a2FoHkhhyz7jISEYhb
         5EfN7A1xjE4R+HBAHglN/slZif9QIysGDCBd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MyHKI7xgzTt0YUZSaYHwYGf4C0qmP6isFfQy6CXF8eE=;
        b=t5Kgi3xGSRY+rikSVMcVysotDoIfKJ8aSswdqDSo9ZCLmMuFVA4K93vaE6MUYjmeR9
         E06eLm+4yGasfwV9G2cXVpH1GkjGmbDeVlhoduXPVVANf9Gdf73bNHBNubpXKTXBisk4
         6XI971iQiD15nOdrn9IA0JkdnDVRD8px7FlPuMw8hgRKaP35fqp9PjX6hgUc85PRgz9A
         VDZMeuLL5sK9opoTZ6ukTHAZ4jfb7O9G9CH6EBsjS6e7swQ6U9LnhyNw+iS9Isa+MIxL
         7N1D0Gucem+JCO2l9rod8yAHSUyB08u1uAJxRG5rufIAyNL4lakZdUaN5FnIS40pFmA1
         4aYQ==
X-Gm-Message-State: APjAAAW8OlNbKQYKxwZoN6wOJtSKDThWkOzvQUSsrcd/flCU/+kWkbKM
        nnk5pUrf+EBXuNc892Wf64T32A==
X-Google-Smtp-Source: APXvYqyK6BYXD2JnT2bsalf6GD4S3SuNqWEInTiKj9x4B3ggE2qvle+hVF2j/Q+Yrwipo7TC/HQTOQ==
X-Received: by 2002:a6b:ef0d:: with SMTP id k13mr5454233ioh.178.1571352595519;
        Thu, 17 Oct 2019 15:49:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o1sm1460207ilm.18.2019.10.17.15.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:49:54 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 16:49:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017120833.GA25548@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/17/19 6:08 AM, Theodore Y. Ts'o wrote:
> On Wed, Oct 16, 2019 at 05:26:29PM -0600, Shuah Khan wrote:
>>
>> I don't really buy the argument that unit tests should be deterministic
>> Possibly, but I would opt for having the ability to feed test data.
> 
> I strongly believe that unit tests should be deterministic.
> Non-deterministic tests are essentially fuzz tests.  And fuzz tests
> should be different from unit tests.
> 

Having the ability to take test data doesn't make it non-deterministic
though. It just means that if user wants to test with a different set
of data, there is no need to recompile the test. This could be helpful
to test cases the test write didn't think about.

You could make the data in this test the default and add ability to
pass in data as needed.

> We want unit tests to run quickly.  Fuzz tests need to be run for a
> large number of passes (perhaps hours) in order to be sure that we've
> hit any possible bad cases.  We want to be able to easily bisect fuzz
> tests --- preferably, automatically.  And any kind of flakey test is
> hell to bisect.
> 

Absolutely.

> It's bad enough when a test is flakey because of the underlying code.
> But when a test is flakey because the test inputs are
> non-deterministic, it's even worse.
> 

That is fine. You can achieve both by making the test data included in
the test the default for deterministic behavior and allow users to
supply another set of data.

thanks,
-- Shuah

