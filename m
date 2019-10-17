Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82ADBA07
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441705AbfJQXIQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Oct 2019 19:08:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441702AbfJQXIQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Oct 2019 19:08:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so6228769qtq.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2019 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+MGmFsYUsxNj4AMmnTJu8GDORDKVCeL1MCXSowaqwY=;
        b=JRJk2uQNwZlLmFLpw82AoLezikHqkV3ZYsbtvvyU7SMwoq63xsUvXTGoO4Ax7ifTGN
         IbDMebpJLpnXo5tLIf5nT/lTftc5IzqvDVGXVXutG1PxobOHjubjAmDHWRDRnLmIn0p3
         ymETpOK47QQQHBvsUqYCs9a9mdpIFIOkCDDun6cxIg9Lm2K+6dIH2nkDqap8UfDry1GB
         w1yiznEgcyHcJa3Vg4V+ySVfJ+wd0coaKOsDiI/y78PJGSYlqSTB83+vrxTGqBgsowcO
         ZIaJYH7/kaodyh9F3tWdySVUVYtmJ2wXwwJ7L2tfxmjOkMV3mzz2nIzMqlpqpJToQdBB
         VZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+MGmFsYUsxNj4AMmnTJu8GDORDKVCeL1MCXSowaqwY=;
        b=gHueEWY6QQDR3WC6/hk98ra6rQXLQMpJ4WF8nLWA3ZAfnhStCI7mgg+tx7N+5WJsOF
         A+iHBaOdhQPAmOOztll3QDYttuel9WOd+jh8TQ0JMer8/D/owvSmhLj0Va9zXsNlh2p8
         K92ZAQFvhuaMdqcNtUwmC/xAEcJeEofDlmLFM+fq7d2BX8fUXAUDxbXXBJogA8lEG1/A
         Tx2kllkVE55bcH4+WuUhnWQOj9321tJPAqtpa0uwbcC5WooU3KlUiMV/8mq6Od+aSpUX
         tfupyrqQPM7WrcndfmiMHXxd8SzoHYnxKUaf2342W/m66Kj15E7lz4k0KuZxrobtexxd
         njjg==
X-Gm-Message-State: APjAAAXpi+9DE2+paE58/QhtABMMmUvMY4SMFWDQMvfmywvqygAZWZFg
        PgJC6Vpcm3MxuhBf+qHCC8O+NgvUghaU4JFk8qbT
X-Google-Smtp-Source: APXvYqwp6n7+BXzD/lu+1d9bRBLTh9XRjzD48NywJn/eB3f9R6NzZBoEWUwlvy3rIZVCrA77Lf+qp1D6WKTwMnVeH50=
X-Received: by 2002:ac8:610e:: with SMTP id a14mr6771951qtm.189.1571353693215;
 Thu, 17 Oct 2019 16:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
In-Reply-To: <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 16:07:36 -0700
Message-ID: <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Having the ability to take test data doesn't make it non-deterministic
> though. It just means that if user wants to test with a different set
> of data, there is no need to recompile the test. This could be helpful
> to test cases the test write didn't think about.
>
Again, unit tests are not meant to be babysat. They are intended to become
a part of the codebase and be run against every proposed change to ensure
the change doesn't break anything.
The whole process is supposed to be fully automated.
Imagine a KUnit test run for all tests that gets kicked off as soon as a patch
shows up in Patchwork and the maintainers getting the test run results.
If you can think of a test that the change author didn't for a new corner case,
then you as the maintainer ask the change author to add such test.
Or if some corner case comes up as a result of a bug then the new case is
submitted with the fix.
This is how unit testing is deployed in the larger software world. In the most
enlightened places a change will not be accepted unless it's accompanied by
the unit tests that offer good coverage for the possible inputs and code paths.
A change that breaks existing tests is either incorrect and has to be fixed or
the existing tests need to be updated for the behavior change.
