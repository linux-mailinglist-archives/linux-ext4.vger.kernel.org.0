Return-Path: <linux-ext4+bounces-1882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8618994C7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 07:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC128820A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70402232B;
	Fri,  5 Apr 2024 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWuJ6oCO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463C1CFB5
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295692; cv=none; b=YSGxl9PfxPY8JiLzB/1wXDas5UnxELzKqLCFO2W0sWwfcS5YbNpVVDWSLqwJrUPCJ/RBPqNnhNRLiO1W3tNV98Oeah0+42xkPYqirNQDZlNwEC1lLhX1cTQhmaIpGtfMuOJn6TRdIWfsNVmNnBw6c/6m+hKJbTKRzT9bV3o0y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295692; c=relaxed/simple;
	bh=f1IdB37wETlUiYibOa4XaON0zQjdQA1tgNosopu1vg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ES6yW9kieSd0P7zCVBNCV/bPS0Q4k0CeUH4SJMlOgXM2R/V798MGo2VAD3BczgV3T+tZRsMeegY8WPt7V/edJn9XQhYRK9El33bCHi2AI6lWP6XKJZ2hENfTu2jVdg37h2HBU8hiI7Yp6WgR9wD1l3uEO07xp82E/tRVdklHEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWuJ6oCO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78bc322a55cso112702485a.1
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712295689; x=1712900489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CZnMpFCZuRTOi4y4AOZ9fdJBdsfzeGtIWt2Xq4UzeJ8=;
        b=kWuJ6oCO7G6EEB9mSxcLYse6/dGatu4w5U2Myq0qqbOdzWRvenDwsm+PVhgrUbwyY3
         oP32XC3FEWk04nPA/rTviRJJ1MWfN2VE2bMcQbXi+6/AlkJiYr++RtyH9UwZ0aqC5gkH
         VAJfrnqPHfB6oFS4cXuROIOscXX+W2xJH6g8q3S3L/uoXwj4Fos2zcSizOBGRN3qj7/j
         G61fFGCKb0RaXbjJK1piRvySHBPHIxLWN3xTUoEpFRPLVGfyOZ2sxB+Zkd1gMjcArvKT
         WOj7Fk/IORwNqgp5vCWGPqIP5qJzbfgv4OKjI6CCvVA9wfkn5EdEtMZ65+UG/SMAl0wu
         zEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295689; x=1712900489;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZnMpFCZuRTOi4y4AOZ9fdJBdsfzeGtIWt2Xq4UzeJ8=;
        b=tiD8+Qtw6fqxH/tRVybYeZlGymICoS67Iy1mO7GC/m7WdVsr+R+qWrOxWaycUMZkMU
         uxjkhkRjHtMMLGFQM8NxaPqZVWUIwWFQBJuBJFdPWZWIIMoQCiVrTfR9YKAKkc834XOk
         LSey3MtskL5APChsiEfrywOQHTH9flqneT0pF+8N3eTL39uCqXx0XOZ6ux78vZufNzz2
         JRshiykg+o1C1y8VhkD4LYoDShk+xhuTPh0CxBT4ZLlMcd0irtu380EFnRGXz7PCL3/y
         ru+iZlOiH6datCZLfTP2bFx6vZhkNnxa6Gwcy1wjOn6q2V3ZYzGWaNiW7X4tsL4WRIn4
         gOdA==
X-Gm-Message-State: AOJu0Yx57h1jASJOS8Z+znQSyzKulhVyU6ntNtUmyePD1n9neK8Itrvb
	ogBIHFpG73934zqfRi9ZAve2v0ekhvSbmf0VjhpFGeaDctHvIC2n0XH4mbPq
X-Google-Smtp-Source: AGHT+IEJHbLlHjXjivyzJ3CUZX5wZzYEooCV+F5Ynek7aXZGvGCXF8iYKi3VSMdJu12mrOlsAruspA==
X-Received: by 2002:a05:620a:1581:b0:78a:5c9e:b606 with SMTP id d1-20020a05620a158100b0078a5c9eb606mr468425qkk.49.1712295688825;
        Thu, 04 Apr 2024 22:41:28 -0700 (PDT)
Received: from [10.1.1.128] (pool-71-179-102-161.bltmmd.fios.verizon.net. [71.179.102.161])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a214700b0078bcbec8693sm365285qkm.91.2024.04.04.22.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 22:41:28 -0700 (PDT)
Message-ID: <ebbeb7b6-e93b-45f8-bea5-d1cfc8db7892@gmail.com>
Date: Fri, 5 Apr 2024 01:41:27 -0400
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: ext4 e2fsck error interpretation and howto fix? expecting
 249045418 actual extent phys 249045427 log 1 len 2
To: linux-ext4@vger.kernel.org
References: <CAMr-kF3yY6zYi2ZBXG7g77zaG2qzA9B294cqL=B7HOtkXYhOeA@mail.gmail.com>
 <20240405042014.GD13376@mit.edu>
Content-Language: en-US
From: "hanasaki@gmail.com" <hanasaki@gmail.com>
Disposition-Notification-To: "hanasaki@gmail.com" <hanasaki@gmail.com>
In-Reply-To: <20240405042014.GD13376@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Theodore,

Thank you so very much! - Arigato!

 >> Theodore Ts'o <tytso@mit.edu>

On 4/5/24 00:20, Theodore Ts'o wrote:
> On Thu, Apr 04, 2024 at 06:23:44PM -0400, Hanasaki Jiji wrote:
>> Hello all,
>>
>> I have an ext4 filesystem with e2fsck reporting many of the below
>> lines.  Neither e2fsck nor fsck fix the issue.
>> Repeated runs result in the same errors.
>>
>> kernel version = linux-image-6.1.0-18-amd64 / Debian Bookworm
>>
>> Your help understanding the output and help fixing are very much appreciated.
>>
>> Thank you,
>>
>> ==== e2fsck output ====
>> 62264184(d): expecting 249045418 actual extent phys 249045427 log 1 len 2
>> 62264185(d): expecting 249045419 actual extent phys 249045429 log 1 len 2
>> 62266954(d): expecting 249045453 actual extent phys 249045486 log 1 len 3
> 
> These aren't problems.  You enabled a debugging feature, via "-E
> fragcheck".  Quoting from the man page:
> 
>         fragcheck
>                During  pass 1, print a detailed report of any discontiguous
> 	      blocks for files in the file system.
> 
> 
> This is intended for use by developers who are trying to assess
> various different block allocation algorithms' fragmentation
> resistance.
> 
> The (d) means directory, and due to how files tend to get added to
> directories, directories are almost certainly going to be
> discontiguous, and with hashed tree indexes, this isn't a performance
> issue.  So arguably fragcheck should really skip printing messages
> about directories.  That being said, given pretty much any workload,
> and utilization approaching 100%, a certain amount of file
> fragmentation is inevitable, so using fragcheck to assess the
> fragmentation resistance of a particular change in a block allocation
> algorithm can only be done using a fixed workload to avoid comparing
> apples versus oranges.
> 
> In any case, unless you are an ext4 developer actively doing block
> allocation work, you really shouldn't be using -E fragcheck.
> 
> Cheers,
> 
> 					- Ted


