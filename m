Return-Path: <linux-ext4+bounces-13010-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A9D3AEC8
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 169573009948
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80238A9D9;
	Mon, 19 Jan 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifH11PWR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70238A728
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835975; cv=none; b=AnkcXkEdrmHbhX4BSVk6BNm9VRLxMVTM329tNRbMGunGLDLJ5/JryMS7JT4lEqU1xuJkhgmhkFFljFrsai8O9L6+r634KfDqDRcnxXBe6gPTmzuQS/Q+fP7sM9lfxLqwocJfbDZh5Oq57fNP6VOWCCg0VAV0VgKxAWSpW2P29xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835975; c=relaxed/simple;
	bh=/v91VxXHu4kfAAmbHZgEA594sj3wviVZHOCvit7EwbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHtbLT997XxUnSEtX9hdzBbXFHD5lRPlM02IJxGl+psRJdeeJnUn9RYWNe6e1WFv/D8mq+ubrB5nPf/mwL7rq/4XA4t19Mt7xJB9t5MW3U0Nbm8kf27BUE0dKHkWwmFMSZGvDwmG054HFye2XyNvpKz/REXtOyNMer2Uh0JnVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifH11PWR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDI7CK007540;
	Mon, 19 Jan 2026 15:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MjeLap1RqQ/8b8W3Uy3H+OHGfTpcHS
	o3HW0ePr8B0eI=; b=ifH11PWRTalTOu6jTtUAj4prPRbAyW9V/4oW8lWN8UDETb
	jMhmv8Jd7wPU4xW3ZYBWPMU+ouMMkgtCcYbA6rhfFg4uoToVmJE3tZSdJvIw7d4A
	Ko+jnq4HxRBcLZiRT/wnbOP5n1eWP3+C27XJtTwsRc4DQ3PHMbyyfFg+0bvafgUm
	9ZB4MO7abwoqc6V2D76beGiZapFm5ZnfEvIc4Gdjg4zMV6IFbuDMIy0rrmPci+HC
	YvE7qLzTYFVdKaDEuvN++Bgl5lUHfNBnnRdlY2t50lFesQgE3v8Q+WxEBFrWeeT5
	WJPplUcnyP/IZNcOIA33aWuCXPUr0ftcekxnNhCg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255ryud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 15:19:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEYsOg001171;
	Mon, 19 Jan 2026 15:19:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjf85h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 15:19:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JFIuBh57409868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 15:18:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB0320043;
	Mon, 19 Jan 2026 15:18:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2994D20040;
	Mon, 19 Jan 2026 15:18:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Jan 2026 15:18:54 +0000 (GMT)
Date: Mon, 19 Jan 2026 20:48:52 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: Re: [tytso-ext4:dev 25/37] fs/ext4/extents-test.c:299:19: warning:
 format '%ld' expects argument of type 'long int', but argument 4 has type
 'int'
Message-ID: <aW5LXG_yhegj1QWT@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <202601190600.xYVh1uKf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601190600.xYVh1uKf-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfXxdpzBoXw5cVn
 RGE6IvlkZ6RlC2VPExUfkU21pjpPGNG4JN9Kw2+3v4I8S/JLbR+m6VLODzrbsAS0kFLOH3CObBo
 MTdNynEVZzNOkcVoKA3Sfnoxs6YtgSmvLmG6toZRdwkX4tvqeAuTm5AvdN+fa37vbFlYSlwQJYU
 t0DPfPRFKGqt9spf+nghbEVCmQ/vbs3MTy6ph13Ft4e3KyMdyieCWWMm1FybdFptDzrB+2ApUmu
 iwsxwvdn0ENiNKMYK4tvodMpUIx5zj2TBc/dQO1fTSUQLkXc9HqkJ1GD8Xg2JOOoJosx4BaZJII
 HUEgMR0FcSh/KNeaOE0kNYd60AhuBR5vIgUQL+yAeeeRloH2YFy6AxW7Kg6J+C3E43/e7/yQ/C5
 wnwKc4q+7kzy4QmH1cB+Xvon4EjG5BlicfHP4n6UYS33Hfe07RSnwRaM35OKjmjWKZcIvurgFZ+
 vRlHFfVSHw9pfu3PZMQ==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696e4b7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8
 a=WjfU5ZQspRoPtC70sM0A:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: dzxiHh6KgsdulKqyrCBqACImchCgI3Ou
X-Proofpoint-ORIG-GUID: dzxiHh6KgsdulKqyrCBqACImchCgI3Ou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190124

On Mon, Jan 19, 2026 at 06:09:58AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> head:   11f1ff3cc21a8e9ca9f509a664de5975469ec561
> commit: 16bbdb54f49e58d51dbf2217bab9ed424172ea9a [25/37] ext4: kunit tests for extent splitting and conversion
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260119/202601190600.xYVh1uKf-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190600.xYVh1uKf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601190600.xYVh1uKf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:31,
>                     from arch/m68k/include/asm/bug.h:32,
>                     from include/linux/bug.h:5,
>                     from include/linux/random.h:6,
>                     from include/linux/nodemask.h:94,
>                     from include/linux/list_lru.h:12,
>                     from include/linux/fs/super_types.h:7,
>                     from include/linux/fs/super.h:5,
>                     from include/linux/fs.h:5,
>                     from fs/ext4/extents.c:20:
>    fs/ext4/extents-test.c: In function 'check_buffer':
>    include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
>        5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
>          |                         ^~~~~~
>    include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ^~~~
>    include/kunit/test.h:661:17: note: in expansion of macro 'printk'
>      661 |                 printk(lvl fmt, ##__VA_ARGS__);                         \
>          |                 ^~~~~~
>    fs/ext4/extents-test.c:298:9: note: in expansion of macro 'kunit_log'
>      298 |         kunit_log(KERN_ALERT, kunit_get_current_test(),
>          |         ^~~~~~~~~
>    include/linux/kern_levels.h:9:25: note: in expansion of macro 'KERN_SOH'
>        9 | #define KERN_ALERT      KERN_SOH "1"    /* action must be taken immediately */
>          |                         ^~~~~~~~
>    fs/ext4/extents-test.c:298:19: note: in expansion of macro 'KERN_ALERT'
>      298 |         kunit_log(KERN_ALERT, kunit_get_current_test(),
>          |                   ^~~~~~~~~~
>    In file included from include/kunit/static_stub.h:18,
>                     from fs/ext4/extents.c:35:
> >> fs/ext4/extents-test.c:299:19: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
>      299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      300 |                   ((char *)ret - buf), c, *((char *)ret));
>          |                   ~~~~~~~~~~~~~~~~~~~
>          |                                |
>          |                                int
>    include/kunit/test.h:662:57: note: in definition of macro 'kunit_log'
>      662 |                 kunit_log_append((test_or_suite)->log,  fmt,            \
>          |                                                         ^~~
>    In file included from fs/ext4/extents.c:6200:
>    fs/ext4/extents-test.c:299:55: note: format string is defined here
>      299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
>          |                                                     ~~^
>          |                                                       |
>          |                                                       long int
>          |                                                     %d
> 
> 
> vim +299 fs/ext4/extents-test.c
> 
>    286	
>    287	/*
>    288	 * Return 1 if all bytes in the buf equal to c, else return the offset of first mismatch
>    289	 */
>    290	static int check_buffer(char *buf, int c, int size)
>    291	{
>    292		void *ret = NULL;
>    293	
>    294		ret = memchr_inv(buf, c, size);
>    295		if (ret  == NULL)
>    296			return 0;
>    297	
>    298		kunit_log(KERN_ALERT, kunit_get_current_test(),
>  > 299			  "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,

Hi,

Thanks for the report, I'll add an explicit cast to 32 bit and fix this.

Thanks,
ojaswin

>    300			  ((char *)ret - buf), c, *((char *)ret));
>    301		return 1;
>    302	}
>    303	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

